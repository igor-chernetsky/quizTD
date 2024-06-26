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

final upgradePriceMap = {
  UpgradeType.range: 200,
  UpgradeType.education: 400,
  UpgradeType.fence: 300,
  UpgradeType.repair: 200,
  UpgradeType.dome: 400
};
