import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/widgets/custom_text_field.dart';
import '../logic/request_provider.dart';

class RequestScreen extends StatelessWidget {
  const RequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RequestProvider(),
      builder: (context, _) {
        final provider = Provider.of<RequestProvider>(context);

        return Scaffold(
          appBar: AppBar(title: Text("Vacation Request")),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Form(
                key: provider.formKey,
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 10,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text("Request a Vacation", style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500)),
                      Text("Date Format: yyyy-mm-dd"),
                      SizedBox(height: 15),
                      CustomTextField(
                        title: "Start Date",
                        controller: provider.startDateController,
                        textInputType: TextInputType.datetime,
                      ),
                      CustomTextField(
                        title: "End Date",
                        controller: provider.endDateController,
                        textInputType: TextInputType.datetime,
                      ),
                      CustomTextField(
                        title: "Reason",
                        controller: provider.reasonController,
                        textInputType: TextInputType.text,
                      ),
                      SizedBox(height: 25),
                      provider.isLoading
                          ? Center(child: CircularProgressIndicator())
                          : MaterialButton(
                        minWidth: double.infinity,
                        color: Colors.blue,
                        shape: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        onPressed: () => provider.sendRequest(context),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Request",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
