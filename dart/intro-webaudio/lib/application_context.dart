class ApplicationContext {
  // Keep track of all loaded buffers.
  Map<String, AudioBuffer> buffers;

  // Page-wide AudioContext.
  AudioContext audioCtx;

  // An object to track the buffers to load "{name: path}".
  static const buffersToLoad = const {
    // There is also example.ogg and example.wav.
    "example": "sounds/example.wav"
  };

  ApplicationContext() {
    buffers = new Map<String, AudioBuffer>();
    audioCtx = new AudioContext();
    _loadBuffers();
  }

  // Loads all sound samples into the buffers object.
  void _loadBuffers() {
    List<String> names = buffersToLoad.keys.toList();
    List<String> paths = buffersToLoad.values.toList();
    var bufferLoader = new BufferLoader(
        audioCtx, paths, (List<AudioBuffer> bufferList) {
      for (var i = 0; i < bufferList.length; i++) {
        AudioBuffer buffer = bufferList[i];
        String name = names[i];
        buffers[name] = buffer;
      }
    });
    bufferLoader.load();
  }
}