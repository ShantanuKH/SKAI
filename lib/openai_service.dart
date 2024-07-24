import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:voice_assistance_app/secreat.dart';

class OpenaiService {
  // To remember our talk
  final List<Map<String, String>> messages = [];
  Future<String> isArtPromptAPI(String prompt) async {
    try {
      final res = await http.post(
          Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $OPENaIAPIKEY',
          },
          body: jsonEncode({
            'model': 'gpt-4o-mini-2024-07-18',
            "messages": [
              {
                'role': 'user',
                "content":
                    'Does this message want to generate an AI picture, image, art or anything similar ? $prompt . Simply answer with YES or NO'
              }
            ]
          }));
      print(res.body);
      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();

        switch (content) {
          case 'Yes':
          case 'yes':
          case 'YES':
          case 'Yes.':
          case 'yes.':
            final res = await dalEAPI(prompt);
            return res;
          default:
            final res = await chatGptAPI(prompt);
        }
      }
      return 'Internal Error !';
    } catch (e) {
      return e.toString();
    }
  }

  Future<String> chatGptAPI(String prompt) async {
    messages.add({'role': 'user', 'content': prompt});
    try {
      final res = await http.post(
          Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $OPENaIAPIKEY',
          },
          body: jsonEncode(
              {'model': 'gpt-4o-mini-2024-07-18', "messages": messages}));

      if (res.statusCode == 200) {
        String content =
            jsonDecode(res.body)['choices'][0]['message']['content'];
        content = content.trim();
        messages.add({'role': 'assistant', 'content': content});
        return content;
      }
      return 'Internal Error !';
    } catch (e) {
      return e.toString();
    }
  }
}

Future<String> dalEAPI(String prompt) async {
  return 'Dal-E';
}
