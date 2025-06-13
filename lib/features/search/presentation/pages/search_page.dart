import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:litlens_v1/features/authentication/presentation/components/my_bottom_navigation_bar.dart';
import 'package:litlens_v1/features/profile/presentation/components/profile_components/user_tile.dart';
import 'package:litlens_v1/features/search/presentation/cubits/search_cubit.dart';
import 'package:litlens_v1/features/search/presentation/cubits/search_states.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController searchController = TextEditingController();
  late final SearchCubit searchCubit;

  void onSearchChanged() {
    final query = searchController.text;
    print("🔍 onSearchChanged -> query: '$query'");
    searchCubit.searchUsers(query);
  }

  @override
  void initState() {
    super.initState();
    try {
      searchCubit = context.read<SearchCubit>();
      print("✔️ SearchCubit recuperado correctamente");
    } catch (e) {
      print("❌ No se pudo acceder a SearchCubit: $e");
    }

    searchController.addListener(onSearchChanged);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: TextField(
          controller: searchController,
          decoration: InputDecoration(
            hintText: "Buscar usuario",
            hintStyle: TextStyle(color: theme.primary),
          ),
        ),
      ),
      body: BlocBuilder<SearchCubit, SearchStates>(
        builder: (context, state) {
          print("🌀 BlocBuilder - estado actual: $state");

          if (state is SearchLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SearchError) {
            print("❌ Error desde el estado SearchError: ${state.message}");
            return Center(child: Text(state.message));
          } else if (state is SearchLoaded) {
            print("✅ Usuarios cargados: ${state.users.length}");

            if (state.users.isEmpty) {
              return const Center(child: Text("No se han encontrado usuarios"));
            }

            return ListView.builder(
              itemCount: state.users.length,
              itemBuilder: (context, index) {
                final user = state.users[index];
                print("👤 Usuario[$index]: $user");

                if (user == null) {
                  print("⚠️ Usuario en posición $index es null");
                  return const SizedBox.shrink();
                }

                return UserTile(user: user);
              },
            );
          }

          return const Center(child: Text("¡Empieza a buscar usuarios!"));
        },
      ),
      // ✅ BottomAppBar con protección contra overflow
      bottomNavigationBar: CustomBottomNavigationBar(
        surface: theme.surface,
        primary: theme.primary,
        inversePrimary: theme.inversePrimary,
        tertiary: theme.tertiary,
        currentPage: PageType.search,
      ),
    );
  }
}
