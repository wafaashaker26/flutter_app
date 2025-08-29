import 'package:demo/core/widgets/custom_text_field.dart';
import 'package:demo/feature/login/logic/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginProvider(),
      builder: (context, _ )
      {
        final provider = context.read<LoginProvider>();
        return Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25,vertical: 15),
            child: SingleChildScrollView(
              child: Form(
                key: provider.formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 25,
                  children: [
                    SizedBox(
                      height: 18,
                    ),
                    Text("Hello..\nLogin....",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: Colors.black)),

                    CustomTextField(
                      title: 'username',
                      controller: provider.usernameController,
                      textInputType: TextInputType.text,
                    ),
                    CustomTextField(
                      title: 'Password',
                      controller: provider.passwordController,
                      textInputType: TextInputType.visiblePassword,
                    ),

                    Consumer<LoginProvider>(
                      builder: (context, _, __) {
                        return provider.isLoading
                            ? Center(child: CircularProgressIndicator())
                            : MaterialButton(
                          minWidth: double.maxFinite,
                          color: Colors.blue,
                          shape: OutlineInputBorder(borderRadius: BorderRadius.circular(20),borderSide: BorderSide(color: Colors.blue)),
                          onPressed: () => provider.login(context),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text("Login",style: TextStyle(fontSize: 25,fontWeight: FontWeight.w500,color: Colors.white),),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );}
    );
  }
}
