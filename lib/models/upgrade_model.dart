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

Map<UpgradeType, String> upgradeNameMap = {
  UpgradeType.range: 'Tower Range',
  UpgradeType.education: 'High Education',
  UpgradeType.fence: 'Electric Fence',
  UpgradeType.repair: 'Building Repair',
  UpgradeType.dome: 'Anti Air System'
};

Map<UpgradeType, String> upgradeDescriptionMap = {
  UpgradeType.range:
      'Increase Tower attack range by 1 square, towers become more efficient.',
  UpgradeType.education:
      'Increase reward for correct answers, each school can have that upgrade.',
  UpgradeType.fence: 'Each enemy getting damaged while attacks your city.',
  UpgradeType.repair: 'Building can be repaired for gold.',
  UpgradeType.dome: 'The protecting dome can hold some amount of air damage.'
};
