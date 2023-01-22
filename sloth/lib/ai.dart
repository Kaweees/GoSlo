import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:openai_client/openai_client.dart';

class AiModel {
  Future<void> main() async {
    // Load app credentials from environment variables or file.
    final configuration = await loadConfigurationFromEnvFile();

    // Create a new client.
    final client = OpenAIClient(
      configuration: configuration,
      enableLogging: true,
    );

    // Fetch the models.
    final models = await client.models.list().data;
    // Print the models list.
    log(models.toString());

    // Fetch a model by ID.
    final modelId = await client.models.byId(id: 'text-davinci-003').data;
    // Print the model.
    log(modelId.toJson().toString());

// How the prompt looks in python:
// prompt = "Give me a list of things to do based on the following prompt.
// The list should be a json list containing objects that consist of the name of the event,
// the location, the coordinates of the location" + input("PROMPT:")
    // Create a completion.
    final completion = await client.completions
        .create(
          model: 'text-davinci-003',
          prompt:
              'Give me a list of things to do based on the following prompt. The list should be a json list containing objects that consist of the name of the event, the location, the coordinates of the location San Luis Obispo',
        )
        .data;
    // Print the completion.
    log(completion.toString());

    // Close the client and terminate the [http] connection.
    client.close();
  }

  /// Loads [OpenAIConfiguration] from environment variables
  /// (`API_KEY`, `ORG_ID`).
  ///
  /// Returns `null` if the variables do not exist.
  Future<OpenAIConfiguration> loadConfigurationFromEnvFile() async {
    //final file = File('.env.json');
    //final content = await file.readAsString();
    //final json = jsonDecode(content) as Map<String, dynamic>;

    return OpenAIConfiguration(
      apiKey: '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',
      organizationId: "",
    );
  }
}
