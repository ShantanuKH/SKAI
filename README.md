# SKAI
SKAI is an innovative voice-assisted application that combines state-of-the-art AI technologies to offer a versatile and interactive user experience. The app is designed to be your personal assistant, capable of handling a range of tasks through voice commands and AI-driven functionalities.

### Key Features of SKAI
1. Voice Interaction
Voice Recognition: SKAI uses the speech_to_text package to transcribe spoken words into text. This feature allows users to interact with the app hands-free, issuing voice commands and receiving responses.
Voice Feedback: With the flutter_tts package, SKAI converts text responses into spoken words, ensuring users get auditory feedback and information.
2. Smart Conversations with ChatGPT
Conversational AI: Integrated with the ChatGPT API, SKAI can hold intelligent conversations. Whether you need answers to questions, help with tasks, or simply want to chat, SKAI leverages ChatGPT to provide relevant and coherent responses.
3. Image Creation with DALL·E
Image Generation: Utilizing the DALL·E API, SKAI can generate images based on textual descriptions provided by the user. This feature lets users create visual content from their imagination, turning descriptive text into detailed images.

### Technologies and Dependencies
Speech-to-Text: Converts spoken language into text for processing voice commands.

Dependency: speech_to_text
- Flutter, Dart

- Text-to-Speech: Converts text into spoken language for feedback and responses.

- Dependency: flutter_tts
  - ChatGPT API: Provides natural language understanding and response generation for engaging in meaningful conversations.

  - DALL·E API: Creates images from textual descriptions, enabling users to visualize concepts and ideas.

### How It Works
- Initialization:

  - Upon starting SKAI, the app initializes the speech_to_text and flutter_tts services to prepare for voice interactions.
- Voice Commands:

  - Users activate the voice recognition feature by pressing a microphone button. SKAI listens for commands, converts them into text, and processes them to provide appropriate responses or actions.
### ChatGPT Integration:

For queries and conversational interactions, SKAI sends the recognized text to the ChatGPT API. It receives a response and uses flutter_tts to read it back to the user.
- Image Creation:

  - Users can request SKAI to generate images by describing what they want. The app sends these descriptions to the DALL·E API, receives the generated images, and displays them.


## Screenshot
<div align="center">
  <table>
    <tr>
      <td align="center">
        <img src="https://raw.githubusercontent.com/ShantanuKH/SKAI/main/ScreeenShot/ss.jpg" alt="HomePage" height="325">
        <br>
        <b>Home Page</b>
      </td>
      
  </table>
</div>


## 📧 Contact

### Shantanu Khadse
  
- GitHub: [ShantanuKH](https://github.com/ShantanuKH)
- Email: shantanukhadse784@gmail.com  
- LinkedIn: [shantanukhadse](https://www.linkedin.com/in/shantanu-khadse-a62585230/)  

