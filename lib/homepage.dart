import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:kindapp/model.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _textEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: AlignmentDirectional.topCenter,
              end: AlignmentDirectional.bottomCenter,
              colors: [
                const Color(0xffE130D0).withOpacity(0.83),
                const Color(0xff3633CA).withOpacity(0.76),
              ],
            ),
          ),
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                pinned: true,
                title: Text(
                  'kindbeing',
                  style: GoogleFonts.comfortaa(color: Colors.white),
                ),
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: 42),
                sliver: ValueListenableBuilder<Box<Gratitude>>(
                  valueListenable: InteractionWithBox.getLogs().listenable(),
                  builder: (context, box, _) {
                    final logs =
                        box.values.toList().cast<Gratitude>().reversed.toList();

                    if (logs.isEmpty) {
                      return const SliverToBoxAdapter(
                        child: Text(
                          'Gratitude is not only the greatest of virtues, but the parent of all the others.',
                          softWrap: true,
                        ),
                      );
                    }
                    return SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => GratitudeCards(
                          gratitude: logs[index],
                        ),
                        childCount: logs.length,
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xfff72585),
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (context) => SingleChildScrollView(
            child: Container(
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 2.0, right: 2.0, top: 4.0),
                    child: Text(
                      'What are you grateful for today?',
                      style: GoogleFonts.comfortaa(fontSize: 24),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: TextField(
                      maxLines: 2,
                      maxLength: 100,
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        hintText:
                            'The smiles, the joy, the AHA! moments, the kindness',
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        ElevatedButton(
                          child: const Text('Add'),
                          onPressed: () async {
                            await addLog(
                              _textEditingController.text,
                            );
                            Navigator.pop(context);
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        child: const Icon(Icons.edit),
      ),
    );
  }

  Future<void> addLog(String gratitudeMessage) async {
    final gratitude = Gratitude()
      ..date = DateTime.now()
      ..journalLog = gratitudeMessage;

    final dbInteraction = InteractionWithBox.getLogs();
    dbInteraction.add(gratitude);
  }

  @override
  void dispose() {
    Hive.close();
    _textEditingController.dispose();
    super.dispose();
  }
}

class InteractionWithBox {
  static Box<Gratitude> getLogs() => Hive.box<Gratitude>('kindlogs');
}

class GratitudeCards extends StatelessWidget {
  const GratitudeCards({Key? key, required this.gratitude}) : super(key: key);

  final Gratitude gratitude;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xffF4FAFD).withOpacity(0.9),
      child: Column(
        children: [
          Align(
            alignment: AlignmentDirectional.topStart,
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                formatDate(gratitude.date, [D, ',', ' ', dd, ' ', M]),
                style: GoogleFonts.raleway(
                  color: const Color.fromARGB(255, 87, 85, 85),
                  fontSize: 12,
                ),
              ),
            ),
          ),
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 4.0,
                top: 12,
                right: 2.0,
                bottom: 40.0,
              ),
              child: Text(
                gratitude.journalLog,
                softWrap: true,
                style: GoogleFonts.raleway(
                  color: Colors.black,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
