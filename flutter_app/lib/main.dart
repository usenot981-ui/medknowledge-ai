import 'package:flutter/material.dart';

void main() => runApp(const MedKnowledgeApp());

class MedKnowledgeApp extends StatefulWidget {
  const MedKnowledgeApp({super.key});
  @override
  State<MedKnowledgeApp> createState() => _MedKnowledgeAppState();
}

class _MedKnowledgeAppState extends State<MedKnowledgeApp> {
  int index = 0;
  bool kannada = false;

  @override
  Widget build(BuildContext context) {
    final pages = [
      HomePage(kannada: kannada, onLearn: () => setState(() => index = 1)),
      LearnPage(kannada: kannada),
      UpdatesPage(kannada: kannada),
      ProfilePage(kannada: kannada),
    ];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MedKnowledge AI',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF087F8C)),
        useMaterial3: true,
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('MedKnowledge AI', style: TextStyle(fontWeight: FontWeight.bold)),
          actions: [
            TextButton(
              onPressed: () => setState(() => kannada = !kannada),
              child: Text(kannada ? 'ಕನ್ನಡ' : 'ಕನ್ನಡ / EN'),
            ),
          ],
        ),
        body: pages[index],
        bottomNavigationBar: NavigationBar(
          selectedIndex: index,
          onDestinationSelected: (v) => setState(() => index = v),
          destinations: [
            NavigationDestination(icon: const Icon(Icons.home_outlined), label: kannada ? 'ಮುಖಪುಟ' : 'Home'),
            NavigationDestination(icon: const Icon(Icons.menu_book_outlined), label: kannada ? 'ಕಲಿಕೆ' : 'Learn'),
            NavigationDestination(icon: const Icon(Icons.newspaper_outlined), label: kannada ? 'ವೈದ್ಯಕೀಯ ಸುದ್ದಿ' : 'Updates'),
            NavigationDestination(icon: const Icon(Icons.person_outline), label: kannada ? 'ಪ್ರೊಫೈಲ್' : 'Profile'),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatelessWidget {
  final bool kannada;
  final VoidCallback onLearn;
  const HomePage({super.key, required this.kannada, required this.onLearn});

  @override
  Widget build(BuildContext context) => ListView(
    padding: const EdgeInsets.all(16),
    children: [
      Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(colors: [Color(0xFF087F8C), Color(0xFF36A6A0)]),
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(kannada ? 'ವೈದ್ಯಕೀಯ ಜ್ಞಾನವನ್ನು ಕಲಿಯಿರಿ' : 'Learn. Understand. Stay updated.',
            style: const TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(kannada ? 'ಪಠ್ಯಪುಸ್ತಕ ಶೈಲಿಯ ಪಾಠಗಳು ಮತ್ತು ಪರಿಶೀಲಿತ ವೈದ್ಯಕೀಯ ಮಾಹಿತಿ.' :
            'Textbook-style lessons and carefully reviewed medical information.',
            style: const TextStyle(color: Colors.white)),
          const SizedBox(height: 14),
          FilledButton.tonal(onPressed: onLearn, child: Text(kannada ? 'ಕಲಿಕೆ ಪ್ರಾರಂಭಿಸಿ' : 'Explore learning')),
        ]),
      ),
      const SizedBox(height: 20),
      Text(kannada ? 'ಮುಖ್ಯ ವಿಭಾಗಗಳು' : 'Learning areas', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 8),
      const FeatureTile(icon: Icons.favorite_outline, title: 'Women’s Health', subtitle: 'Menstrual cycle, hormones and reproductive health'),
      const FeatureTile(icon: Icons.face_retouching_natural, title: 'Skin Science', subtitle: 'Skin anatomy, acne and dermatological conditions'),
      const FeatureTile(icon: Icons.spa_outlined, title: 'Hair & Scalp', subtitle: 'Hair growth, hair loss and scalp conditions'),
      const FeatureTile(icon: Icons.school_outlined, title: 'Exam Learning', subtitle: 'Notes, MCQs, short answers and viva preparation'),
    ],
  );
}

class FeatureTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  const FeatureTile({super.key, required this.icon, required this.title, required this.subtitle});
  @override
  Widget build(BuildContext context) => Card(
    child: ListTile(
      leading: CircleAvatar(child: Icon(icon)),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.chevron_right),
    ),
  );
}

class LearnPage extends StatelessWidget {
  final bool kannada;
  const LearnPage({super.key, required this.kannada});
  @override
  Widget build(BuildContext context) {
    final topics = [
      ('Menstrual Cycle', 'ಋತುಚಕ್ರ', 'Four phases, hormones, ovulation and common menstrual disorders.'),
      ('Skin Anatomy & Acne', 'ಚರ್ಮದ ರಚನೆ ಮತ್ತು ಮೊಡವೆ', 'Skin layers, acne types, prevention and treatment principles.'),
      ('Hair Growth & Scalp', 'ಕೂದಲು ಮತ್ತು ತಲೆಚರ್ಮ', 'Hair follicle, growth cycle, hair loss and scalp disorders.'),
    ];
    return ListView(padding: const EdgeInsets.all(16), children: [
      Text(kannada ? 'ಪಠ್ಯಪುಸ್ತಕ ಕಲಿಕೆ' : 'Textbook learning', style: Theme.of(context).textTheme.headlineSmall),
      const SizedBox(height: 8),
      Text(kannada ? 'ಮೂಲಭೂತಗಳಿಂದ ಕ್ಲಿನಿಕಲ್ ಅರ್ಥೈಸುವಿಕೆಯವರೆಗೆ.' : 'Build understanding from foundations to clinical concepts.'),
      const SizedBox(height: 12),
      for (final t in topics)
        Card(child: ListTile(
          leading: const Icon(Icons.menu_book),
          title: Text(kannada ? t.$2 : t.$1),
          subtitle: Text(t.$3),
          trailing: const Icon(Icons.arrow_forward_ios, size: 16),
          onTap: () => Navigator.push(context, MaterialPageRoute(
            builder: (_) => TopicPage(title: kannada ? t.$2 : t.$1, topic: t.$1))),
        )),
      const SizedBox(height: 12),
      const Text('Introductory sample content. Full chapters require subject-expert review.',
        style: TextStyle(fontSize: 12, color: Colors.deepOrange)),
    ]);
  }
}

class TopicPage extends StatelessWidget {
  final String title;
  final String topic;
  const TopicPage({super.key, required this.title, required this.topic});

  @override
  Widget build(BuildContext context) {
    final List<(String, String)> sections = topic == 'Menstrual Cycle'
      ? [
        ('Overview', 'The menstrual cycle is a hormone-coordinated process involving the ovaries and uterus. Cycle length is counted from the first day of one period to the first day of the next.'),
        ('Four phases', 'Menstrual phase: the uterine lining is shed. Follicular phase: ovarian follicles develop and estrogen rises. Ovulation: an LH surge triggers egg release. Luteal phase: progesterone supports the uterine lining.'),
        ('Key hormones', 'FSH supports follicle development; LH triggers ovulation; estrogen helps rebuild the endometrium; progesterone supports the lining after ovulation.'),
        ('When to seek care', 'Seek medical assessment for very heavy bleeding, severe pain, fainting, persistent irregularity or bleeding after menopause.'),
      ]
      : topic == 'Skin Anatomy & Acne'
      ? [
        ('Skin layers', 'The epidermis is the outer barrier, the dermis contains connective tissue, vessels, nerves and follicles, and the hypodermis contains fat and connective tissue.'),
        ('Acne', 'Acne involves blocked follicles, sebum and inflammation. Lesions include comedones, papules, pustules and nodules.'),
        ('Care principles', 'Gentle cleansing, non-comedogenic moisturiser and sun protection can support skin health. Treatments must be selected with appropriate guidance.'),
        ('Warning signs', 'Rapidly spreading redness, fever, severe pain, facial swelling or a changing suspicious mole needs medical assessment.'),
      ]
      : [
        ('Hair structure', 'The hair shaft emerges from a follicle associated with a sebaceous gland.'),
        ('Growth cycle', 'Anagen is active growth, catagen is transition, telogen is rest and exogen is shedding.'),
        ('Common conditions', 'Dandruff, seborrhoeic dermatitis, alopecia areata, pattern hair loss, telogen effluvium and fungal scalp infections have different causes and treatments.'),
        ('Assessment', 'Persistent or patchy hair loss may need evaluation for scalp disease, thyroid problems, iron deficiency, medication effects or other causes.'),
      ];
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        for (final s in sections) ...[
          Text(s.$1, style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 6),
          Text(s.$2),
          const SizedBox(height: 18),
        ],
        const Divider(),
        const Text('Educational content only. It does not replace care from a qualified health professional.',
          style: TextStyle(fontSize: 12, fontStyle: FontStyle.italic)),
      ]),
    );
  }
}

class UpdatesPage extends StatelessWidget {
  final bool kannada;
  const UpdatesPage({super.key, required this.kannada});
  @override
  Widget build(BuildContext context) {
    final items = [
      ('Drug safety alerts', 'Verified medicine recalls, warnings and restrictions.', 'Priority'),
      ('Clinical guidelines', 'Changes from recognised health authorities.', 'Under review'),
      ('Medical research', 'New studies, reviews and clinical-trial developments.', 'Research'),
      ('Indian health news', 'Public-health announcements and medical developments.', 'News'),
    ];
    return ListView(padding: const EdgeInsets.all(16), children: [
      Text(kannada ? 'ವೈದ್ಯಕೀಯ ಅಪ್‌ಡೇಟ್‌ಗಳು' : 'Medical Updates', style: Theme.of(context).textTheme.headlineSmall),
      const SizedBox(height: 8),
      Text(kannada ? 'ತುರ್ತು ಪರಿಶೀಲಿತ ಎಚ್ಚರಿಕೆಗಳು ಮತ್ತು ದೈನಂದಿನ ವೈದ್ಯಕೀಯ ಸುದ್ದಿ.' :
        'Immediate important alerts and a daily medical news digest.'),
      const SizedBox(height: 12),
      for (final item in items)
        Card(child: ListTile(
          leading: const Icon(Icons.notifications_active_outlined),
          title: Text(item.$1),
          subtitle: Text(item.$2),
          trailing: Chip(label: Text(item.$3)),
        )),
      const SizedBox(height: 12),
      const Text('Live source monitoring and push delivery are not connected in this starter build.',
        style: TextStyle(fontSize: 12, color: Colors.deepOrange)),
    ]);
  }
}

class ProfilePage extends StatelessWidget {
  final bool kannada;
  const ProfilePage({super.key, required this.kannada});
  @override
  Widget build(BuildContext context) => ListView(padding: const EdgeInsets.all(16), children: [
    const CircleAvatar(radius: 34, child: Icon(Icons.person, size: 36)),
    const SizedBox(height: 12),
    Center(child: Text(kannada ? 'ಕಲಿಯುವವರು' : 'Learner', style: Theme.of(context).textTheme.titleLarge)),
    const SizedBox(height: 20),
    const ListTile(leading: Icon(Icons.language), title: Text('Language'), subtitle: Text('English / ಕನ್ನಡ')),
    const ListTile(leading: Icon(Icons.notifications_outlined), title: Text('Notifications'),
      subtitle: Text('Immediate important alerts + daily medical news (planned)')),
    const ListTile(leading: Icon(Icons.privacy_tip_outlined), title: Text('Privacy & safety'),
      subtitle: Text('Educational information; protect personal health data.')),
  ]);
}
