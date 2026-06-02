# Python: Konversi model ke TFLite dengan quantization
import tensorflow as tf

# Load model Keras/SavedModel
converter = tf.lite.TFLiteConverter.from_saved_model('saved_model/')

# === Dynamic Range Quantization ===
converter.optimizations = [tf.lite.Optimize.DEFAULT]
tflite_model = converter.convert()

with open('model_quantized.tflite', 'wb') as f:
    f.write(tflite_model)
print('Model quantized!')