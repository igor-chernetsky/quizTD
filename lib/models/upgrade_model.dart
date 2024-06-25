class UpgradeModel {
  bool range;
  bool fence;
  bool repair;
  bool dome;
  bool education;

  UpgradeModel(
      {this.range = false,
      this.education = false,
      this.fence = false,
      this.repair = false,
      this.dome = false});
}

enum UpgradeType { range, fence, repair, dome, education }
