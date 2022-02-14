import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:puzzle_challenge/app/bloc/game_bloc.dart';
import 'package:puzzle_challenge/app/widgets/game_box.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<GameCubit>(
          create: (_) => GameCubit(),
        )
      ],
      child: Scaffold(
        body: SafeArea(
          child: Builder(
            builder: _buildBody,
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildHeader(),
        _buildGrid(context),
        _buildShuffleButton(),
      ],
    );
  }

  Widget _buildHeader() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: const [
        SizedBox(height: 32),
        Text(
          'Puzzle Challenge',
          style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
        ),
        Text(
          '0 Moves | 15 Tiles',
          style: TextStyle(fontSize: 20, color: Colors.blue),
        ),
      ],
    );
  }

  Widget _buildShuffleButton() {
    return TextButton.icon(
      onPressed: () {},
      icon: const Icon(
        Icons.replay,
        color: Colors.white,
      ),
      label: const Text(
        'Shuffle',
        style: TextStyle(color: Colors.white),
      ),
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue,
        fixedSize: const Size.fromWidth(150),
        shape: const StadiumBorder(),
      ),
    );
  }

  Widget _buildGrid(BuildContext context) {
    final width = MediaQuery.of(context).size.width - 32;
    final blockSize = width / 4;

    final boxes = context.select((GameCubit cubit) => cubit.state.board);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Stack(
        children: [
          SizedBox(
            width: width,
            height: width,
          ),
          for (var box in boxes)
            if (box != null)
              GameBox(
                key: Key(box.value),
                box: box,
                size: blockSize,
                onSwipe: (box, direction) {
                  context.read<GameCubit>().move(box, direction);
                },
              )
        ],
      ),
    );
  }
}
