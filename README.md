
</head>
<body>
  <h1>🚀 ProTasker</h1>
  <p class="badges">
    <img src="https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter" alt="Flutter" />
    <img src="https://img.shields.io/badge/Firebase-v11-orange?logo=firebase" alt="Firebase" />
    <img src="https://img.shields.io/badge/License-MIT-green" alt="License" />
  </p>
  <p>
    <strong>ProTasker</strong> is a cross‑platform productivity & on‑demand service app built with
    <a href="https://flutter.dev" target="_blank" rel="noopener">Flutter</a>, powered by
    <a href="https://firebase.google.com" target="_blank" rel="noopener">Firebase</a>, and enriched with Google
    <a href="https://developers.google.com/maps" target="_blank" rel="noopener">Maps</a> integration. Organize your
    projects, collaborate with teammates in real time, and even book trusted professionals for everyday needs like
    plumbing, house painting, or appliance repair — all within a beautiful blue‑grey & teal UI.
  </p>

  <h2>✨ Features</h2>
  <ul>
    <li>Create, update & delete tasks with intuitive swipe gestures</li>
    <li>Browse and request home‑service professionals (plumbing, painting, electrical, repairs, etc.)</li>
    <li>Real‑time data sync using Cloud Firestore</li>
    <li>Assign tasks to collaborators and track status</li>
    <li>Interactive map view for location‑based tasks & service providers</li>
    <li>Smart reminders & push notifications (Firebase Cloud Messaging)</li>
    <li>Secure authentication (Email/Password, Google, Apple)</li>
    <li>Offline caching & background sync</li>
    <li>Light & dark themes with custom color palette</li>
  </ul>

  <h2>🖼️ Screenshots</h2>

Here are some key screenshots from the application:
<table>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/98cb5e98-8353-4ac3-836c-09be7b6cdd7b" alt="Screen 1" width="300"/><br/>
      <sub>Screen 1</sub>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/92cad1e9-966d-409c-83ad-d553bd3f565a" alt="Screen 2" width="300"/><br/>
      <sub>Screen 2</sub>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/b8e4b6fb-50ce-4d28-8eef-4b142fe41b2f" alt="Screen 3" width="300"/><br/>
      <sub>Screen 3</sub>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/ba32579c-191b-4689-a5dd-6bce194038df" alt="Screen 4" width="300"/><br/>
      <sub>Screen 4</sub>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/9d4aca16-1351-4cb2-b12b-0871a70a12cb" alt="Screen 5" width="300"/><br/>
      <sub>Screen 5</sub>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/30670d4c-dde4-42ce-ba13-9e48e9621923" alt="Screen 6" width="300"/><br/>
      <sub>Screen 6</sub>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/9f4a836c-f065-4bd1-8947-17791862f780" alt="Screen 7" width="300"/><br/>
      <sub>Screen 7</sub>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/8c0d5afc-bc6b-4eb9-ad30-8283cbbb14a4" alt="Screen 8" width="300"/><br/>
      <sub>Screen 8</sub>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/15c0c218-dc30-4dba-8859-6d1edeaf175e" alt="Screen 9" width="300"/><br/>
      <sub>Screen 9</sub>
    </td>
  </tr>
  <tr>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/64d87911-72ab-459e-90c3-ddf54a100c38" alt="Screen 10" width="300"/><br/>
      <sub>Screen 10</sub>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/91fbe077-e852-4a6d-9d79-4ebfc32100e3" alt="Screen 11" width="300"/><br/>
      <sub>Screen 11</sub>
    </td>
    <td align="center">
      <img src="https://github.com/user-attachments/assets/a60164b7-9f1e-4342-bc9c-de000a627762" alt="Screen 12" width="300"/><br/>
      <sub>Screen 12</sub>
    </td>
  </tr>
</table>







  <h2>🏗️ Tech Stack</h2>
  <table>
    <thead>
      <tr>
        <th>Category</th>
        <th>Libraries / Services</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>Frontend</td>
        <td>Flutter 3, Riverpod / Provider, GoRouter</td>
      </tr>
      <tr>
        <td>Backend‑as‑a‑Service</td>
        <td>Firebase Auth, Cloud Firestore, Cloud Functions, Cloud Messaging, Firebase Storage</td>
      </tr>
      <tr>
        <td>Maps & Geolocation</td>
        <td>google_maps_flutter, geolocator</td>
      </tr>
      <tr>
        <td>CI/CD</td>
        <td>GitHub Actions, Flutter Test, Firebase Hosting preview channels</td>
      </tr>
    </tbody>
  </table>

  <h2>🚀 Getting Started</h2>
  <ol>
    <li>
      <strong>Clone the repo</strong>
      <pre><code>git clone https://github.com/&lt;your‑username&gt;/protasker.git
cd protasker</code></pre>
    </li>
    <li>
      <strong>Install dependencies</strong>
      <pre><code>flutter pub get</code></pre>
    </li>
    <li>
      <strong>Configure Firebase</strong>
      <p>
        Install <code>flutterfire_cli</code> if you haven’t already, then run:
      </p>
      <pre><code>flutterfire configure</code></pre>
      <p>This generates <code>firebase_options.dart</code> & updates native files.</p>
    </li>
    <li>
      <strong>Add Google Maps API keys</strong>
      <pre><code># .env (recommended)
ANDROID_MAPS_API_KEY=AIzaSy...
IOS_MAPS_API_KEY=AIzaSy...</code></pre>
      <p>
        Reference these in <code>android/app/src/main/AndroidManifest.xml</code> and
        <code>ios/Runner/AppDelegate.swift</code> (or via <code>flutter_dotenv</code>).
      </p>
    </li>
    <li>
      <strong>Run the app</strong>
      <pre><code>flutter run</code></pre>
    </li>
  </ol>

  <h2>🧪 Tests</h2>
  <pre><code>flutter test</code></pre>

  <h2>📦 Build & Release</h2>
  <p>
    GitHub Actions workflows in <code>.github/workflows/</code> automate building and distributing the app on every push to
    <code>main</code>.
  </p>

  <h2>🤝 Contributing</h2>
  <ol>
    <li>Fork the repository</li>
    <li>Create a feature branch (<code>git checkout -b feature/awesome</code>)</li>
    <li>Commit your changes (<code>git commit -m "feat: add awesome"</code>)</li>
    <li>Push to your fork (<code>git push origin feature/awesome</code>)</li>
    <li>Open a Pull Request and describe your change</li>
  </ol>
  <p>
    Please read our <a href="CODE_OF_CONDUCT.md">Code of Conduct</a> and follow the contribution guidelines.
  </p>


  <h2>💬 Contact & Support</h2>
  <ul>
    <li><a href="https://github.com/Va09joshi">Issue Tracker</a></li>
    <li>Email: <a href="mailto:vaibhavjoshi0709@gmail.com">vaibhavjoshi0709@gmail.com</a></li>
  </ul>

  <hr />
  <p align="center">
    <em>Built with ❤️ in Flutter • Firebase • Google Maps</em>
  </p>
</body>
</html>
