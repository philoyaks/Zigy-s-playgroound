import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/constant_string.dart';
import '../../../../core/shared_widgets/app_textfield.dart';
import '../../../../core/utils/textfield_validators.dart';
import '../../data/models/users_model.dart';
import '../bloc/users_bloc.dart';

class ModalCreationWidget extends StatelessWidget {
  ModalCreationWidget({
    Key? key,
  }) : super(key: key);
  final TextEditingController emailController = TextEditingController();
  final TextEditingController firstNameControllerr = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController avatarController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  submitUserCreation(UserData user, BuildContext context) {
    context.read<UsersBloc>().add(CreateUserEvent(user: user));
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.9,
      child: Container(
        padding: EdgeInsets.only(
            left: 20,
            right: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              const SizedBox(
                height: 60,
              ),
              const Text('Please Enter Detaiils'),
              const SizedBox(
                height: 30,
              ),
              AppTextfield(
                controller: emailController,
                validator: TextFieldValidator.validateEmail,
                hintText: 'Enter your Email',
                spacing: 20,
              ),
              AppTextfield(
                controller: firstNameControllerr,
                hintText: 'Enter your First Name',
                validator: TextFieldValidator.isNotEmpty,
                spacing: 20,
              ),
              AppTextfield(
                controller: lastNameController,
                validator: TextFieldValidator.isNotEmpty,
                hintText: 'Enter your Last Name',
                spacing: 20,
              ),
              AppTextfield(
                controller: avatarController,
                hintText: 'Enter your Image link: Optional',
                spacing: 30,
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context);
                        submitUserCreation(
                            UserData(
                              email: emailController.text,
                              firstName: firstNameControllerr.text,
                              lastName: lastNameController.text,
                              avatar: avatarController.text.isEmpty
                                  ? AppConstants.defaultAvatarLink
                                  : avatarController.text,
                            ),
                            context);
                      }
                    },
                    child: const Text('Create User')),
              )
            ],
          ),
        ),
      ),
    );
  }
}
