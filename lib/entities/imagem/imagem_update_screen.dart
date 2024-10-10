import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Cocoverde/entities/imagem/bloc/imagem_bloc.dart';
import 'package:flutter/material.dart';
import 'package:Cocoverde/shared/repository/http_utils.dart';
import 'imagem_route.dart';

class ImagemUpdateScreen extends StatelessWidget {
  ImagemUpdateScreen({Key? key}) : super(key: ImagemRoutes.editScreenKey);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImagemBloc, ImagemState>(
      listener: (context, state) {
        if(state.formStatus.isSuccess){
          Navigator.pushNamed(context, ImagemRoutes.list);
        }
      },
      child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: BlocBuilder<ImagemBloc, ImagemState>(
                buildWhen: (previous, current) => previous.editMode != current.editMode,
                builder: (context, state) {
                String title = state.editMode == true ?'Edit Imagems':
'Create Imagems';
                 return Text(title);
                }
            ),
          ),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(15.0),
            child: Column(children: <Widget>[settingsForm(context)]),
          ),
      ),
    );
  }

  Widget settingsForm(BuildContext context) {
    return Form(
      child: Wrap(runSpacing: 15, children: <Widget>[
          nameField(),
          contentTypeField(),
          descriptionField(),
        validationZone(),
        submit(context)
      ]),
    );
  }

      Widget nameField() {
        return BlocBuilder<ImagemBloc, ImagemState>(
            buildWhen: (previous, current) => previous.name != current.name,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ImagemBloc>().nameController,
                  onChanged: (value) { context.read<ImagemBloc>()
                    .add(NameChanged(name:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'name'));
            }
        );
      }
      Widget contentTypeField() {
        return BlocBuilder<ImagemBloc, ImagemState>(
            buildWhen: (previous, current) => previous.contentType != current.contentType,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ImagemBloc>().contentTypeController,
                  onChanged: (value) { context.read<ImagemBloc>()
                    .add(ContentTypeChanged(contentType:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'contentType'));
            }
        );
      }
      Widget descriptionField() {
        return BlocBuilder<ImagemBloc, ImagemState>(
            buildWhen: (previous, current) => previous.description != current.description,
            builder: (context, state) {
              return TextFormField(
                  controller: context.read<ImagemBloc>().descriptionController,
                  onChanged: (value) { context.read<ImagemBloc>()
                    .add(DescriptionChanged(description:value)); },
                  keyboardType:TextInputType.text,                  decoration: InputDecoration(
                      labelText:'description'));
            }
        );
      }


  Widget validationZone() {
    return BlocBuilder<ImagemBloc, ImagemState>(
        buildWhen:(previous, current) => previous.formStatus != current.formStatus,
        builder: (context, state) {
          return Visibility(
              visible: state.formStatus.isFailure ||  state.formStatus.isSuccess,
              child: Center(
                child: generateNotificationText(state, context),
              ));
        });
  }

  Widget generateNotificationText(ImagemState state, BuildContext context) {
    String notificationTranslated = '';
    Color? notificationColors;

    if (state.generalNotificationKey.toString().compareTo(HttpUtils.errorServerKey) == 0) {
      notificationTranslated ='Something wrong when calling the server, please try again';
      notificationColors = Theme.of(context).colorScheme.error;
    } else if (state.generalNotificationKey.toString().compareTo(HttpUtils.badRequestServerKey) == 0) {
      notificationTranslated ='Something wrong happened with the received data';
      notificationColors = Theme.of(context).colorScheme.error;
    }

    return Text(
      notificationTranslated,
      textAlign: TextAlign.center,
      style: TextStyle(fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
          color: notificationColors),
    );
  }

  submit(BuildContext context) {
    return BlocBuilder<ImagemBloc, ImagemState>(
        buildWhen: (previous, current) => previous.isValid != current.isValid,
        builder: (context, state) {
          String buttonLabel = state.editMode == true ?
'Edit':
'Create';
          return ElevatedButton(
            child: Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: Visibility(
                    replacement: CircularProgressIndicator(value: null),
                    visible: !state.formStatus.isInProgress,
                    child: Text(buttonLabel),
                  ),
                )),
            onPressed: state.isValid ? () => context.read<ImagemBloc>().add(ImagemFormSubmitted()) : null,
          );
        }
    );
  }
}
