import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:voice_assistance_app/secreat.dart';

class OpenaiService {
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
          'model': 'gpt-3.5-turbo',
          'messages': [
            {
              'role': 'user',
              'content': 'Does this message want to generate an AI picture, image, art or anything similar? $prompt. Simply answer with YES or NO',
            }
          ],
        }),
      );

      print('isArtPromptAPI status code: ${res.statusCode}');
      print('isArtPromptAPI response body: ${res.body}');

      if (res.statusCode == 200) {
        String content = jsonDecode(res.body)['choices'][0]['message']['content'].trim();

        if (content.toLowerCase().contains('yes')) {
          return await dalEAPI(prompt);
        } else {
          return await chatGptAPI(prompt);
        }
      } else {
        return 'Internal Error: ${res.statusCode}';
      }
    } catch (e) {
      return 'Error: $e';
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
        body: jsonEncode({
          'model': 'gpt-3.5-turbo', 
          'messages': messages,
        }),
      );

      print('chatGptAPI status code: ${res.statusCode}');
      print('chatGptAPI response body: ${res.body}');

      if (res.statusCode == 200) {
        String content = jsonDecode(res.body)['choices'][0]['message']['content'].trim();
        messages.add({'role': 'assistant', 'content': content});
        return content;
      } else {
        return 'Internal Error: ${res.statusCode}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }

  Future<String> dalEAPI(String prompt) async {
    try {
      final res = await http.post(
        Uri.parse('https://api.openai.com/v1/images/generations'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $OPENaIAPIKEY',
        },
        body: jsonEncode({
          'prompt': prompt,
          'n': 1,
          'size': '1024x1024',
        }),
      );

      print('dalEAPI status code: ${res.statusCode}');
      print('dalEAPI response body: ${res.body}');

      if (res.statusCode == 200) {
        String imageUrl = jsonDecode(res.body)['data'][0]['url'];
        return imageUrl;
      } else {
        return 'Internal Error: ${res.statusCode}';
      }
    } catch (e) {
      return 'Error: $e';
    }
  }
}
