import 'package:flutter/material.dart';
import '../services/api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ApiService api = ApiService();
  final TextEditingController nomeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController senhaController = TextEditingController();
  List<Map<String, dynamic>> usuarios = [];

  @override
  void initState() {
    super.initState();
    _loadUsuarios();
  }

  Future<void> _loadUsuarios() async {
    usuarios = await api.fetchUsuarios();
    setState(() {});
  }

  Future<void> _createUsuario() async {
    if (await api.createUsuario(
        nomeController.text, emailController.text, senhaController.text)) {
      nomeController.clear();
      emailController.clear();
      senhaController.clear();
      _loadUsuarios();
    }
  }

  Future<void> _deleteUsuario(int id) async {
    await api.deleteUsuario(id);
    _loadUsuarios();
  }

  Future<void> _updateUsuario(int id) async {
    await api.updateUsuario(id, nomeController.text, emailController.text);
    nomeController.clear();
    emailController.clear();
    _loadUsuarios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Usuários')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: nomeController, decoration: const InputDecoration(labelText: 'Nome')),
            TextField(controller: emailController, decoration: const InputDecoration(labelText: 'Email')),
            TextField(controller: senhaController, decoration: const InputDecoration(labelText: 'Senha')),
            const SizedBox(height: 10),
            Row(
              children: [
                ElevatedButton(onPressed: _createUsuario, child: const Text('Criar')),
              ],
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: usuarios.length,
                itemBuilder: (context, index) {
                  final u = usuarios[index];
                  return ListTile(
                    title: Text(u['nome']),
                    subtitle: Text(u['email']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            nomeController.text = u['nome'];
                            emailController.text = u['email'];
                            _updateUsuario(u['id']);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () => _deleteUsuario(u['id']),
                        ),
                      ],
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
