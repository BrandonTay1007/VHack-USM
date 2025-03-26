import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SymptomCheckerPage extends StatefulWidget {
  const SymptomCheckerPage({Key? key}) : super(key: key);

  @override
  _SymptomCheckerPageState createState() => _SymptomCheckerPageState();
}

class _SymptomCheckerPageState extends State<SymptomCheckerPage> {
  final TextEditingController _symptomController = TextEditingController();
  String _result = '';
  List<String> _history = [];

  final List<String> _commonSymptoms = [
    'Fever',
    'Cough',
    'Headache',
    'Fatigue',
    'Sore throat',
    'Nausea',
    'Shortness of breath'
  ];

  void _analyzeSymptoms() {
    final input = _symptomController.text.toLowerCase().trim();
    if (input.isEmpty) return;

    _history.add(input);

    // Mock AI Logic (Replace with real model later)
    if (input.contains("fever") && input.contains("cough")) {
      _result =
          "🦠 Possible Illness: Flu or COVID-19\n\n💡 Advice: Drink fluids, isolate, rest, and consult a doctor.";
    } else if (input.contains("headache")) {
      _result =
          "🧠 Possible Illness: Migraine or Stress-related headache\n\n💡 Advice: Reduce screen time, stay hydrated, rest in a dark room.";
    } else {
      _result =
          "✅ No major illness detected.\n\n💡 Advice: Keep monitoring, eat healthily, and stay hydrated.";
    }

    setState(() {});
    _symptomController.clear();
  }

  void _selectSymptom(String symptom) {
    final current = _symptomController.text;
    if (!current.toLowerCase().contains(symptom.toLowerCase())) {
      _symptomController.text =
          current.isEmpty ? symptom : '$current, $symptom';
    }
  }

  void _clearAll() {
    setState(() {
      _symptomController.clear();
      _result = '';
      _history.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "AI Symptom Checker",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        backgroundColor: const Color(0xFFB4E4BE),
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.black),
            onPressed: _clearAll,
            tooltip: "Clear All",
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Describe your symptoms or select from common ones:",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8,
              runSpacing: 4,
              children: _commonSymptoms
                  .map((symptom) => ActionChip(
                        label: Text(
                          symptom,
                          style: GoogleFonts.poppins(color: Colors.black),
                        ),
                        backgroundColor: const Color(0xFFA7D8F5),
                        onPressed: () => _selectSymptom(symptom),
                      ))
                  .toList(),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _symptomController,
              maxLines: 2,
              style: GoogleFonts.poppins(color: Colors.black),
              decoration: InputDecoration(
                labelText: "Your symptoms",
                labelStyle: GoogleFonts.poppins(color: Colors.black87),
                hintText: "e.g. fever, headache, cough",
                hintStyle: GoogleFonts.poppins(color: Colors.black54),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(color: Color(0xFFB4E4BE)),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear, color: Color(0xFFC5A8FF)),
                  onPressed: () => _symptomController.clear(),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Center(
              child: ElevatedButton.icon(
                icon: const Icon(Icons.search, color: Colors.black),
                label: Text(
                  "Analyze Symptoms",
                  style: GoogleFonts.poppins(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFB4E4BE),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 12,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: _analyzeSymptoms,
              ),
            ),
            const SizedBox(height: 30),
            if (_result.isNotEmpty)
              Card(
                color: const Color(0xFFA7D8F5).withOpacity(0.2),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    _result,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            const SizedBox(height: 20),
            if (_history.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "📝 Symptom History",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ..._history.reversed.map(
                    (symptom) => ListTile(
                      leading: Icon(
                        Icons.history,
                        color: const Color(0xFFC5A8FF),
                      ),
                      title: Text(
                        symptom,
                        style: GoogleFonts.poppins(color: Colors.black87),
                      ),
                    ),
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
} 