import 'package:eo_app/models/event_organizer.dart';
import 'package:flutter/material.dart';
import '../services/api_services.dart';
import 'roomchat_screen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final ApiServices _apiServices = ApiServices();
  List<EventOrganizerModel> _eoList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchChatContacts();
  }

  Future<void> _fetchChatContacts() async {
    final eos = await _apiServices.getEventOrganizers();
    if (mounted) {
      setState(() {
        _eoList = eos;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Color(0xFF0D2546),
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              image: DecorationImage(
                image: AssetImage('assets/images/ballroom.jpg'),
                fit: BoxFit.cover,
                opacity: 0.2,
              ),
            ),
            child: const SafeArea(
              child: Align(
                alignment: Alignment.center,
                child: Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    'CHAT',
                    style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold, letterSpacing: 1.2),
                  ),
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 10),


          Expanded(
            child: _isLoading 
              ? const Center(child: CircularProgressIndicator())
              : _eoList.isEmpty
                  ? const Center(child: Text('Belum ada Event Organizer', style: TextStyle(color: Colors.grey)))
                  : ListView.separated(
                      padding: const EdgeInsets.all(0),
                      itemCount: _eoList.length,
                      separatorBuilder: (context, index) => const Divider(height: 1, thickness: 1),
                      itemBuilder: (context, index) {
                        final eo = _eoList[index];
                        
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
                          leading: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 4, offset: Offset(0, 2))],
                            ),
                            child: CircleAvatar(
                              radius: 30,
                              backgroundColor: Colors.grey.shade300,
                              backgroundImage: eo.image != null && eo.image!.isNotEmpty
                                  ? NetworkImage(eo.image!) as ImageProvider
                                  : const AssetImage('assets/images/ballroom.jpg'),
                            ),
                          ),
                          title: Text(
                            eo.name,
                            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          subtitle: const Padding(
                            padding: EdgeInsets.only(top: 4),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ChatRoomScreen(eo: eo),
                              ),
                            );
                          },
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}