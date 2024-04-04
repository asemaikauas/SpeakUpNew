import 'package:get/get.dart';
import 'package:speakup/features/speakup/screens/map_screen.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechController extends GetxController {
  late stt.SpeechToText speech;
  final RxBool _isListening = false.obs;
  final RxString listenText = ''.obs;

  void listen() async {
    if (!_isListening.value) {
      bool available = await speech.initialize(
        onStatus: (status) {
          if (status == "done") {
            _isListening.value = false;
            Get.to(MapScreen(
              text: listenText.value.toString(),
            ));
          }
          print('onStatus: $status');
        },
        onError: (error) {
          print('onError: $error');
        },
      );
      if (available) {
        _isListening.value = true;
        speech.listen(onResult: (result) {
          listenText.value = result.recognizedWords;
          print(listenText.value);
        });
      } else {
        _isListening.value = false;
        speech.stop();

      }
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    speech = stt.SpeechToText();

    super.onInit();
  }

  bool get isListening => _isListening.value;

  set isListening(bool value) {
    _isListening.value = value;
  }
}
