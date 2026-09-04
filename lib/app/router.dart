import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/calcule/calcule_screen.dart';
import '../features/clienti/client_form_screen.dart';
import '../features/clienti/clienti_screen.dart';
import '../features/registru/lucrare_detail_screen.dart';
import '../features/registru/lucrare_form_screen.dart';
import '../features/registru/registru_screen.dart';
import '../features/registru/estimare_screen.dart';
import '../features/registru/solutie_detail_screen.dart';
import '../core/models/solutie.dart';
import '../features/setari/setari_screen.dart';

final _rootKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  navigatorKey: _rootKey,
  initialLocation: '/registru',
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => _Scaffold(shell: shell),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/registru',
              builder: (context, state) => const RegistruScreen(),
              routes: [
                GoRoute(
                  path: 'noua',
                  parentNavigatorKey: _rootKey,
                  builder: (context, state) => const LucrareFormScreen(),
                ),
                GoRoute(
                  path: ':id',
                  builder: (context, state) =>
                      LucrareDetailScreen(id: state.pathParameters['id']!),
                  routes: [
                    GoRoute(
                      path: 'editare',
                      parentNavigatorKey: _rootKey,
                      builder: (context, state) =>
                          LucrareFormScreen(id: state.pathParameters['id']),
                    ),
                    GoRoute(
                      path: 'estimare',
                      parentNavigatorKey: _rootKey,
                      builder: (context, state) => EstimareScreen(
                        lucrareId: state.pathParameters['id']!,
                        deLa: state.extra as IntrariSolutie?,
                      ),
                    ),
                    GoRoute(
                      path: 'solutie/:sid',
                      parentNavigatorKey: _rootKey,
                      builder: (context, state) => SolutieDetailScreen(
                        lucrareId: state.pathParameters['id']!,
                        solutieId: state.pathParameters['sid']!,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/clienti',
              builder: (context, state) => const ClientiScreen(),
              routes: [
                GoRoute(
                  path: 'nou',
                  parentNavigatorKey: _rootKey,
                  builder: (context, state) => const ClientFormScreen(),
                ),
                GoRoute(
                  path: ':id',
                  parentNavigatorKey: _rootKey,
                  builder: (context, state) =>
                      ClientFormScreen(id: state.pathParameters['id']),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/calcule',
              builder: (context, state) => const CalculeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/setari',
              builder: (context, state) => const SetariScreen(),
            ),
          ],
        ),
      ],
    ),
  ],
);

class _Scaffold extends StatelessWidget {
  final StatefulNavigationShell shell;
  const _Scaffold({required this.shell});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: shell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: shell.currentIndex,
        onDestinationSelected: (i) =>
            shell.goBranch(i, initialLocation: i == shell.currentIndex),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.folder_open_outlined),
            selectedIcon: Icon(Icons.folder),
            label: 'Registru',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline),
            selectedIcon: Icon(Icons.people),
            label: 'Clienți',
          ),
          NavigationDestination(
            icon: Icon(Icons.calculate_outlined),
            selectedIcon: Icon(Icons.calculate),
            label: 'Calcule',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings_outlined),
            selectedIcon: Icon(Icons.settings),
            label: 'Setări',
          ),
        ],
      ),
    );
  }
}
