import sounddevice as sd
from pydub import AudioSegment
import numpy as np
import threading
import time
import csv

# Configurações de áudio
sample_rate = 48000
duration = 5  # Duração da gravação em segundos

# Função para gravar áudio de um microfone
def record_microphone(device_id, filename):
    array_times = []
    array_times.append(time.time_ns())
    audio_data = sd.rec(int(sample_rate * duration), samplerate=sample_rate, channels=1, device=device_id, dtype="int16")
    sd.wait()
    array_times.append(time.time_ns())

    audio_segment = AudioSegment(
        data=bytes(np.array(audio_data, dtype=np.int16).tobytes()),
        sample_width=2,
        frame_rate=sample_rate,
        channels=1,
    )
    array_times.append(time.time_ns())
    print((array_times[1]-array_times[0])/1000/1000)
    audio_segment.export(filename + ".wav", format="wav")

    filename1 = filename + ".csv"

    with open(filename1, mode='w', newline='') as dt:
        d = csv.writer(dt)
        # Escreva os dados no arquivo CSV
        d.writerow(array_times)

# IDs dos dispositivos de áudio (microfones)
input_devices = [1, 2, 3]  # Substitua pelos IDs dos seus dispositivos

# Inicialize threads para gravar áudio de três microfones simultaneamente
threads = []
for i, device_id in enumerate(input_devices):
    filename = f"FR_T4_microfone_{i + 1}"
    thread = threading.Thread(target=record_microphone, args=(device_id, filename), daemon=True)
    threads.append(thread)
    thread.start()

# Aguarde o término de todas as threads
for thread in threads:
    thread.join()
