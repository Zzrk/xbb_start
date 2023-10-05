import origin from './origin.json' assert { type: "json" };
import fs from 'fs';

const typeMap = {
  '力量': '力',
  '敏捷': '敏',
  '智力': '智',
}

const stageMap = {
  '蓝2': '蓝+2',
  '紫0': '紫',
  '紫1': '紫+1',
  '紫2': '紫+2',
  '紫3': '紫+3',
  '紫4': '紫+4',
}

let temp = {
  name: '',
  type: '',
  star: 0,
  stages: []
}
const result = [];
origin.forEach((item) => {
  const name = item['名称'];
  const type = typeMap[item['属性']];
  const star = 0;
  const stage = stageMap[item['阶级']];
  const equipments = [item['装备1'], item['装备2'], item['装备3'], item['装备4'], item['装备5'], item['装备6']].map(i => i === '(待补充)' ? '' : i);
  const level = item['等级'] - 0;

  if (temp.name !== name) {
    temp = {
      name,
      type,
      star,
      stages: [{ stage, equipments, level }]
    }
    result.push(temp);
  } else [
    temp.stages.push({ stage, equipments, level })
  ]
});

fs.writeFileSync('./result.json', JSON.stringify(result, null, 2));