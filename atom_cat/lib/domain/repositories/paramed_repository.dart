import 'package:atom_cat/domain/models/article.dart';

class ParamedRepository{
  final List<Article> articlesList = [
    Article('assets/images/plast.png', 'Отморожение и переохлаждение',
        'Утеплить пораженные участки тела и обездвижить их, укутать пострадавшего теплой одеждой или пледом, дать теплое питье, переместить в теплое помещение.'),
    Article('assets/images/plast.png', 'Кровотечение', 'Нужно остановить'),
    Article('assets/images/plast.png', 'Кровотечение', 'Нужно остановить'),
    Article('assets/images/plast.png', 'Кровотечение', 'Нужно остановить'),
    Article('assets/images/plast.png', 'Кровотечение', 'Нужно остановить'),
    Article('assets/images/plast.png', 'Кровотечение', 'Нужно остановить'),
  ];

  Article getArticleByNumber(int index){
    return articlesList[index];
  }
}