import '../../ request_vacation/ui/request_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../ request_vacation/logic/request_provider.dart';
import '../logic/profile_provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ProfileProvider()..loadProfile(),
      builder: (context, _) {
        final provider = context.watch<ProfileProvider>();
        final profileData = provider.profileData;

        return Scaffold(
          appBar: AppBar(
            title: const Text("Profile"),
            backgroundColor: Colors.blue,
            centerTitle: true,
          ),
          body: provider.isLoading
              ? const Center(child: CircularProgressIndicator())
              : profileData == null
              ? const Center(child: Text("Failed to load profile"))
              : Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("ID: ${profileData['id']}", style: TextStyle(fontSize: 22)),
                  Text("Username: ${profileData['username']}", style: TextStyle(fontSize: 22)),
                  Text("Age: ${profileData['age']}", style: TextStyle(fontSize: 22)),
                  Text("Experience: ${profileData['experience']}", style: TextStyle(fontSize: 22)),
                  Text("National ID: ${profileData['national_id']}", style: TextStyle(fontSize: 22)),
                  Text("Vacation Days: ${profileData['balance_vacations_days']}", style: TextStyle(fontSize: 22)),
                  Text("User ID: ${profileData['user_id']}", style: TextStyle(fontSize: 22)),
                  SizedBox(height: 30,),
                  MaterialButton(
                      onPressed: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ChangeNotifierProvider(
                              create: (_) => RequestProvider(),
                              child: const RequestScreen(),
                            ),
                          ),
                        );

                      },
                    minWidth: double.maxFinite,
                    color: Colors.blue,
                    shape: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.blue,),borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Ask Vacations" ,style: TextStyle(fontSize: 22)),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
