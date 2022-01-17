import 'package:flutterapp/dataparsing.dart';
import 'package:http/http.dart' as http;




class Services{

  static const String url = 'https://api.datamuse.com/words?rel_rhy=duck';

  static Future<List<RhymeWord>> getRhymeWords() async{


      final response = await http.get(Uri.parse('https://api.datamuse.com/words?rel_rhy=duck'));

      if(200 == response.statusCode){

        final List<RhymeWord> rhymeWords = rhymeWordFromJson(response.body);
        return rhymeWords;

      }else{
        throw Exception('Failed to load words ll');
      }


  }




}