
# System Architecture – SpeakUpP

SpeakUpP is a mobile-first speech therapy application designed to support children with speech disorders. Below is the technical architecture of the system.

## 🧱 Tech Stack

- **Frontend**: React Native (mobile application)
- **Backend**: Firebase and Supabase (authentication, data storage, hosting)
- **AI Integration**: OpenAI Whisper API (speech recognition)
- **Bot Interface**: Telegram Bot API (accessible interaction layer)
- **Styling**: Tailwind CSS (for styling components)

## ⚙️ Architecture Diagram (Text)

```
[User] → [Mobile App (React Native)]
        → [Speechy Bot] → [Telegram Bot API]
        → [Speech Recognition] → [OpenAI Whisper]
        → [Database & Auth] → [Firebase / Supabase]
```

## 🔐 Security

- Authentication via Firebase/Supabase
- Secure cloud storage of progress and audio templates
- Parental controls and access limitations

## 🌐 Scalability

The app is designed to scale to support additional languages, therapy content, and real-time therapist communication modules.
