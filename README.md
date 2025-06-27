
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
  <p>
    <img src="docs/screenshots/board.png" width="260" class="screenshot" alt="Kanban board screenshot" />
    <img src="docs/screenshots/map.png" width="260" class="screenshot" alt="Map view screenshot" />
    <img src="docs/screenshots/services.png" width="260" class="screenshot" alt="Service booking screenshot" />
  </p>

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

  <h2>📄 License</h2>
  <p>
    This project is licensed under the MIT License – see the
    <a href="LICENSE">LICENSE</a> file for details.
  </p>

  <h2>💬 Contact & Support</h2>
  <ul>
    <li><a href="https://github.com/&lt;your‑username&gt;/protasker/issues">Issue Tracker</a></li>
    <li>Email: <a href="mailto:maintainer@example.com">maintainer@example.com</a></li>
  </ul>

  <hr />
  <p align="center">
    <em>Built with ❤️ in Flutter • Firebase • Google Maps</em>
  </p>
</body>
</html>
