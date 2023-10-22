import fs from "fs";

const text = fs.readFileSync("origin.json", "utf-8");
const origin = JSON.parse(text);

const typeMap = {
  力量: "力",
  敏捷: "敏",
  智力: "智",
};

const stageMap = {
  蓝2: "蓝+2",
  紫0: "紫",
  紫1: "紫+1",
  紫2: "紫+2",
  紫3: "紫+3",
  紫4: "紫+4",
};

const nameMap = {
  骷髅王: "骨王",
  末日: "末日使者",
  全能: "全能骑士",
  天怒: "天怒法师",
};

const equipmentMap = {
  天堂: "天堂之刃",
  深渊: "深渊之刃",
  黑皇: '黑黄',
  驱魔头巾: '魔抗头巾',
  // '疾行鞋': '飞鞋',
};

const starMap = [
  [
    "全能骑士",
    "潮汐",
    "刚背猪",
    "船长",
    "小黑",
    "火枪",
    "云游武僧",
    "巫医",
    "火女",
    "小鹿",
    "宙斯",
  ],
  [
    "大鱼人",
    "骨王",
    "人马",
    "尸王",
    "凤凰",
    "军团指挥",
    "狼人",
    "海民",
    "小小",
    "白虎",
    "巨魔",
    "敌法",
    "影魔",
    "复仇",
    "小娜迦",
    "冰女",
    "双头龙",
    "光法",
    "舞姬",
    "暗牧",
    "恶魔巫师",
    "骨法",
    "蓝胖",
    "修补匠",
  ],
  [
    "末日使者",
    "发条",
    "斧王",
    "黑暗骑士",
    "酒仙",
    "屠芙",
    "神牛",
    "战神",
    "电魂",
    "幻影刺客",
    "剑圣",
    "美杜莎",
    "拍拍熊",
    "月骑",
    "白银刺客",
    "骨弓",
    "猴子",
    "亚龙",
    "育母蜘蛛",
    "灵魂守卫",
    "圣堂刺客",
    "巫妖",
    "德鲁伊",
    "黑暗先知",
    "术士",
    "沉默",
    "风行",
    "黑鸟",
    "痛苦女王",
    "天怒法师",
  ],
];

let temp = {
  name: "",
  type: "",
  star: 0,
  stages: [],
};
const result = [];

origin.forEach((item) => {
  const _name = item["名称"];
  const name = nameMap[_name] || _name;
  const category = typeMap[item["属性"]];
  const star = starMap.findIndex((i) => i.includes(name)) + 1;
  const stage = stageMap[item["阶级"]];
  const stageIndex = Object.values(stageMap).findIndex((i) => i === stage);
  const level = item["等级"] - 0;

  const _equipments = [
    item["装备1"],
    item["装备2"],
    item["装备3"],
    item["装备4"],
    item["装备5"],
    item["装备6"],
  ].map((i) => (i === "(待补充)" ? "" : i));
  const equipments = _equipments.map((i) => equipmentMap[i] || i);

  if (name === '全能骑士' && stage === '蓝+2') {
    equipments[5] = '秘法鞋';
  }

  if (temp.name !== name) {
    const stages = [];
    stages[stageIndex] = { stage, equipments, level };
    temp = {
      name,
      category,
      star,
      stages,
    };
    result.push(temp);
  } else {
    temp.stages[stageIndex] = { stage, equipments, level };
  }
});

fs.writeFileSync("./result.json", JSON.stringify(result, null, 2));
