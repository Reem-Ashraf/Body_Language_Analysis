import 'package:easy_sidemenu/easy_sidemenu.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/view/componant/pages/screens%20in%20Home%20Page/camera.dart';
import 'package:graduation_project/view_model/layout_cubit/layout_cubit.dart';
class LayOutStudent extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>LayoutCubit(),
      child: BlocConsumer<LayoutCubit,LayoutState>(
        listener: (BuildContext context,LayoutState state){},
        builder: (BuildContext context ,LayoutState state){
          LayoutCubit Cubit =LayoutCubit.get(context);
          return Scaffold(body: Row(children: [
            
          ],),);
        },
      ),
    );
  }
}
