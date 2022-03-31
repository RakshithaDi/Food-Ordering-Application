import 'package:food_ordering_application/widgets/voteitem.dart';

class ViewVotes {
  static List<VoteItem> VoteItems = [];
  static void add(VoteItem item) {
    VoteItems.add(item);
  }

  static List<VoteItem> get getVoteItems {
    return VoteItems;
  }
}
