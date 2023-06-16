import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'komponen.dart' as dataglobal;
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(RekapVotingPage());
}

class RekapVotingPage extends StatefulWidget {
  const RekapVotingPage({Key? key}) : super(key: key);

  @override
  State<RekapVotingPage> createState() => _RekapVotingPageState();
}

class _RekapVotingPageState extends State<RekapVotingPage> {
  final _user = FirebaseFirestore.instance
      .collection('users')
      .where('username', isEqualTo: dataglobal.username)
      .limit(1)
      .snapshots();

  bool hasVoted = false;
  int selectedOption = 0;
  int option1Votes = 0;
  int option2Votes = 0;
  String? username;
  int totalVotes = 0;

  final _users = FirebaseFirestore.instance.collection('votes');

  Future<void> getUserId(String username) async {
    try {
      QuerySnapshot snapshot = await _user.first;
      if (snapshot.docs.isNotEmpty) {
        DocumentSnapshot documentSnapshot = snapshot.docs.first;
        Map<String, dynamic> userData =
            documentSnapshot.data() as Map<String, dynamic>;
        setState(() {
          this.username = userData['username'] as String;
        });
      }
    } catch (error) {
      print('Error while retrieving user data: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    getUsername().then((value) {
      checkVoteStatus().then((hasVotedValue) {
        // Menambahkan parameter hasVotedValue
        setState(() {
          hasVoted =
              hasVotedValue; // Menggunakan nilai hasVotedValue dari checkVoteStatus
        });
      });
    });
  }

  Future<String?> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? username = prefs.getString('username');
    if (username != null) {
      setState(() {
        this.username = username;
      });
    }
    return username;
  }

  Future<bool> checkVoteStatus() async {
    try {
      if (username != null) {
        DocumentSnapshot snapshot = await _users.doc(username!).get();
        if (snapshot.exists) {
          setState(() {
            hasVoted = true;
            selectedOption = snapshot['option'] as int;
          });
          return true;
        }
      }
    } catch (error) {
      print('Error while checking vote status: $error');
    }
    return false;
  }

  void voteForOption(int option) async {
    if (!hasVoted) {
      await _users.doc(username).set({'option': option});
      setState(() {
        hasVoted = true;
        selectedOption = option;
        if (option == 1) {
          option1Votes++;
        } else if (option == 2) {
          option2Votes++;
        }
        totalVotes = option1Votes + option2Votes; // Tambahkan ini
      });
    }
  }

  double calculatePercentage(int votes, int totalVotes) {
    if (totalVotes == 0) {
      return 0.0;
    } else {
      return (votes / totalVotes) * 100;
    }
  }

  @override
  Widget build(BuildContext context) {
    int totalVotes = option1Votes + option2Votes;
    double option1Percentage = calculatePercentage(option1Votes, totalVotes);
    double option2Percentage = calculatePercentage(option2Votes, totalVotes);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        title: const Text(
          "Hasil Vote",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: const EdgeInsets.all(7),
            child: Image.asset(
              "assets/logo_kpu.png",
            ),
          )
        ],
      ),
      body: StreamBuilder(
        stream: _user,
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];
                return Container(
                  padding: const EdgeInsets.only(left: 16, top: 25, right: 16),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    child: Column(
                      children: [
                        Center(
                          child: Column(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                height: 80,
                                width: 250,
                                color: Colors.transparent,
                                alignment: Alignment.center,
                                child: const Text(
                                  'HASIL PEMILIHAN KEPALA DAERAH KOTA BANDUNG 2024',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Column(
                                    children: [
                                      Card(
                                        margin: const EdgeInsets.all(15),
                                        color: Colors.white,
                                        shape: Border.all(color: Colors.red),
                                        child: SizedBox(
                                          width: 300,
                                          height: 230,
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Image.asset(
                                                'assets/paslon1.jpeg',
                                                height: 100,
                                                width: 150,
                                              ),
                                              VotingOption(
                                                optionText:
                                                    'Giri Ramanda & Yudistira R.',
                                                voteCount: option1Votes,
                                                totalVotes: totalVotes,
                                                percentage: option1Percentage,
                                                isSelected: selectedOption == 1,
                                                onPressed: () {
                                                  voteForOption(1);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      const SizedBox(
                                        width: 20,
                                      ),
                                      Card(
                                        margin: const EdgeInsets.all(15),
                                        color: Colors.white,
                                        shape: Border.all(color: Colors.red),
                                        child: SizedBox(
                                          width: 300,
                                          height: 230,
                                          child: Column(
                                            children: [
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Image.asset(
                                                'assets/paslon2.jpg',
                                                height: 100,
                                                width: 150,
                                              ),
                                              VotingOption(
                                                optionText:
                                                    'Nurul Arifin & H.A.M. Nurdin H.',
                                                voteCount: option2Votes,
                                                totalVotes: totalVotes,
                                                percentage: option2Percentage,
                                                isSelected: selectedOption == 2,
                                                onPressed: () {
                                                  voteForOption(2);
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      hasVoted
                                          ? Padding(
                                              padding:
                                                  const EdgeInsets.all(20.0),
                                              child: Text(
                                                'Anda telah memilih $selectedOption',
                                                style: const TextStyle(
                                                  fontSize: 18.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            )
                                          : SizedBox(),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}

class VotingOption extends StatelessWidget {
  final String optionText;
  final int voteCount;
  final int totalVotes;
  final double percentage;
  final bool isSelected;
  final VoidCallback onPressed;

  VotingOption({
    required this.optionText,
    required this.voteCount,
    required this.totalVotes,
    required this.percentage,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(10.0),
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
          color: isSelected ? Colors.red : Colors.white,
          borderRadius: BorderRadius.circular(10.0),
          border: Border.all(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        child: Column(
          children: [
            Text(
              optionText,
              style: TextStyle(
                fontSize: 18.0,
                color: isSelected ? Colors.white : Colors.red,
              ),
            ),
            const SizedBox(height: 10.0),
            Text(
              '$voteCount Suara (${percentage.toStringAsFixed(2)}%)',
              style: TextStyle(
                fontSize: 14.0,
                color: isSelected ? Colors.white : Colors.red,
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check,
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
