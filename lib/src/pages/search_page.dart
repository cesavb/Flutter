import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_movie_list/src/pages/info_page.dart';
import 'package:flutter_movie_list/src/repositories/shows_repository.dart';

class SearchPage extends SearchDelegate<String> {
  @override
  String get searchFieldLabel => 'Digite o filme ou a série';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: Icon(Icons.clear))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder<Map>(
        future: resultado(query),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView(
              children: [
                Image.network(snapshot.data!['poster']),
                Padding(
                  padding: EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text(snapshot.data!['name'])],
                      )
                    ],
                  ),
                )
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao pesquisar o filme ou serie desejado'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }));
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final repository = RepositoryShows();

    if (query.isEmpty) {
      return Container();
    }
    return FutureBuilder<List>(
        future: sugestoes(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: ((context, index) {
                  return Card(
                    child: SizedBox(
                      width: 300,
                      height: 100,
                      child: Center(
                        child: ListTile(
                          onTap: () {
                            query = snapshot.data![index]['id'];
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => InfoPage(
                                      title: snapshot.data![index]['name'],
                                      id: snapshot.data![index]['id'],
                                      gen: snapshot.data![index]['genres'],
                                      poster: snapshot.data![index]['image'],
                                      summary: snapshot.data![index]['summary'],
                                      day: snapshot.data![index]['days'],
                                      hour: snapshot.data![index]['time'],
                                    )));
                          },
                          leading: SizedBox(
                              width: 80,
                              height: 80,
                              child: Image.network(snapshot.data![index]
                                      ['image']['medium']['original']
                                  .toString())),
                          title: Text(snapshot.data![index]['name'],
                              style: const TextStyle(
                                  fontSize: 20,
                                  color: Color.fromARGB(255, 39, 52, 34))),
                        ),
                      ),
                    ),
                  );
                }));
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao pesquisar o filme ou serie desejado'),
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        }));
  }

  Future<List> sugestoes() async {
    final client = Dio(BaseOptions(baseUrl: 'https://api.tvmaze.com'));
    final response = await client.get('/shows?q=$searchFieldLabel');

    if (response.statusCode == 200) {
      return json
          .decode(json.encode(response.data))
          .map((show) => show)
          .toList();
    }
    throw Exception('Não foi possivel solicitar o filme ou serie desejado');
  }

  Future<Map<String, dynamic>> resultado(String id) async {
    final client = Dio(BaseOptions(baseUrl: 'https://api.tvmaze.com'));
    final response = await client.get('/show/$id');

    if (response.statusCode == 200) {
      return json.decode(response.data);
    }
    throw Exception('Não foi possivel solicitar o filme ou serie desejado');
  }
}

//newString.replaceAll(' ', '+');