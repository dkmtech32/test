import 'package:flutter/material.dart';

import 'widgets/detail_text_field.dart';

// ignore: must_be_immutable
class AddDetails extends StatelessWidget {
  AddDetails({super.key});
  TextEditingController fullNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add profile'),
        centerTitle: true,

        actions: [
          TextButton(onPressed: () {
            
          }, child: Text('Save',style: TextStyle(fontSize: 18),))
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.all(size.width/16),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Stack(
                  children: [
                    CircleAvatar(
                      radius: 55,
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Icon(
                          Icons.add_a_photo,
                          size: 30,
                        ))
                  ],
                ),
                const SizedBox(height: 25,),
                DetailsTextFeild(nameController: fullNameController, hintText: 'Full name', obscureText: false,maxLines: 1),
                const SizedBox(height: 25,),
                DetailsTextFeild(nameController: userNameController, hintText: 'username', obscureText: false,maxLines: 1),
                const SizedBox(height: 25,),
                DetailsTextFeild(nameController: bioController, hintText: 'Bio', obscureText: false,maxLines: 6,),
                              const SizedBox(height: 20,),
                             
          
          
          
              ],
            ),
          ),
        ),
      ),
    );
  }
}