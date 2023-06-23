import 'package:qr_flutter/qr_flutter.dart';

import '../../packages/exports.dart';

class ViewORCode extends StatefulWidget {
  const ViewORCode({
    super.key,
  });

  @override
  State<ViewORCode> createState() => _ViewORCodeState();
}

class _ViewORCodeState extends State<ViewORCode> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          QrImageView(
            data: '${currentuser.uid}',
            version: QrVersions.auto,
            size: 80,
            gapless: false,
            errorStateBuilder: (cxt, err) {
              return const Center(
                child: Text(
                  'Uh oh! Something went wrong...',
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
