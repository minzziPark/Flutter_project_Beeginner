import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarComponent extends StatelessWidget {
  const AppBarComponent({
    super.key,
    required this.state,
  });
  final String state;

  @override
  PreferredSizeWidget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      toolbarHeight: 100,
      titleSpacing: 0,
      title: Column(
        children: [
          Container(
            width: 125,
            child: SvgPicture.asset(
              'assets/images/Beeginner.svg',
              width: 125,
            ),
          ),
          Row(
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color:
                            Color.fromRGBO(255, 226, 12, 1), // 아래 border 색상 설정
                        width: (state) == 'todo' ? 3.0 : 0.5, // 아래 border 두께 설정
                      ),
                    ),
                  ),
                  child: TextButton(
                    child: const Text(
                      '오늘의 할 일',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3, // 텍스트 버튼 폭 설정
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: (state) == 'schedule'
                            ? Color.fromRGBO(255, 226, 12, 1)
                            : Color.fromRGBO(
                                230, 224, 233, 1), // 아래 border 색상 설정
                        width: (state) == 'schedule'
                            ? 3.0
                            : 0.1, // 아래 border 두께 설정
                      ),
                    ),
                  ),
                  child: TextButton(
                    child: const Text(
                      '일정표',
                      style: TextStyle(color: Colors.black),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: (state) == 'tip'
                            ? Color.fromRGBO(255, 226, 12, 1)
                            : Color.fromRGBO(
                                230, 224, 233, 1), // 아래 border 색상 설정
                        width: (state) == "tip" ? 3.0 : 0.1, // 아래 border 두께 설정
                      ),
                    ),
                  ),
                  child: TextButton(
                    child: const Text('꿀 팁',
                        style: TextStyle(color: Colors.black)),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
          Container(
            child: Divider(
              height: 0,
              thickness: 0.5,
              color: Color.fromRGBO(230, 224, 233, 1),
            ),
          ),
        ],
      ),
    );
  }
}
