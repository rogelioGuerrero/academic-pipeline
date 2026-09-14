const EC={navy:'#14213d',blue:'#1a56db',gold:'#b8860b',red:'#d93025',green:'#2e7d32',grid:'#e5e2db',txt:'#555'};
const AX=()=>({axisLine:{lineStyle:{color:'#bbb'}},axisLabel:{color:EC.txt,fontSize:11},splitLine:{lineStyle:{color:EC.grid}},nameTextStyle:{color:EC.txt}});
let worldGeoPromise=null;
function getWorldGeo(){if(!worldGeoPromise){worldGeoPromise=fetch('https://cdn.jsdelivr.net/npm/echarts@4.9.0/map/json/world.json').then(r=>r.ok?r.json():Promise.reject()).then(g=>{echarts.registerMap('world',g);return true;}).catch(()=>false);}return worldGeoPromise;}
    function buildChartOption(f) {
      const tt = { backgroundColor: '#fff', borderColor: '#ddd', textStyle: { color: '#333', fontSize: 12 } };
      if (f.type === 'scatter') {
        return {
          grid: { left: 80, right: 30, top: 36, bottom: 50 },
          title: { text: `r = ${f.r.toFixed(3)}  (p = ${f.p.toFixed(4)}, n = ${f.n})`, textStyle: { fontSize: 12, color: '#888', fontWeight: 'normal' }, left: 'center', top: 4 },
          tooltip: { ...tt, formatter: p2 => `${p2.data[2]} — x: ${p2.data[0].toFixed(2)}, y: ${p2.data[1].toFixed(2)}` },
          xAxis: { type: 'value', name: f.x_label, nameLocation: 'middle', nameGap: 32, scale: true, ...AX() },
          yAxis: { type: 'value', name: f.y_label, nameLocation: 'middle', nameGap: 55, scale: true, ...AX() },
          series: [
            { type: 'scatter', data: f.points, symbolSize: 13, itemStyle: { color: EC.blue } },
            { type: 'line', data: [[f.fit.x_min, f.fit.m * f.fit.x_min + f.fit.b], [f.fit.x_max, f.fit.m * f.fit.x_max + f.fit.b]], showSymbol: false, lineStyle: { color: EC.red, type: 'dashed', width: 2 }, tooltip: { show: false }, silent: true }
          ]
        };
      }
      if (f.type === 'fit') {
        return {
          grid: { left: 80, right: 30, top: 36, bottom: 62 },
          title: { text: `Observado vs ajustado — R² = ${f.r2.toFixed(3)}`, textStyle: { fontSize: 12, color: '#888', fontWeight: 'normal' }, left: 'center', top: 4 },
          tooltip: { ...tt, trigger: 'axis' },
          legend: { bottom: 4, textStyle: { color: EC.txt } },
          xAxis: { type: 'category', data: f.years, name: 'Año', nameLocation: 'middle', nameGap: 28, ...AX(), splitLine: { show: false } },
          yAxis: { type: 'value', name: f.dep, nameLocation: 'middle', nameGap: 55, scale: true, ...AX() },
          series: [
            { name: 'Observado', type: 'line', data: f.observed, symbolSize: 7, lineStyle: { width: 2.2, color: EC.blue }, itemStyle: { color: EC.blue } },
            { name: 'Ajustado (OLS)', type: 'line', data: f.fitted, symbol: 'rect', symbolSize: 7, lineStyle: { width: 2, type: 'dashed', color: EC.red }, itemStyle: { color: EC.red } }
          ]
        };
      }
      if (f.type === 'bars') {
        return {
          grid: { left: 10, right: 40, top: 36, bottom: 44, containLabel: true },
          title: { text: `${f.indicator} (${f.year})`, textStyle: { fontSize: 12, color: '#888', fontWeight: 'normal' }, left: 'center', top: 4 },
          tooltip: { ...tt, formatter: p2 => `${p2.name}: ${(+p2.value).toFixed(2)}` },
          xAxis: { type: 'value', ...AX() },
          yAxis: { type: 'category', data: f.items.map(i => i.cc), ...AX(), splitLine: { show: false } },
          series: [{ type: 'bar', data: f.items.map(i => i.value), barMaxWidth: 26, itemStyle: { color: EC.navy }, label: { show: true, position: 'right', color: EC.txt, formatter: p2 => (+p2.value).toFixed(1) } }]
        };
      }
      if (f.type === 'forest') {
        return {
          grid: { left: 10, right: 50, top: 36, bottom: 44, containLabel: true },
          title: { text: 'Coeficientes con IC 95% — las barras que cruzan 0 son frágiles', textStyle: { fontSize: 12, color: '#888', fontWeight: 'normal' }, left: 'center', top: 4 },
          tooltip: { ...tt, formatter: p2 => { const e = f.entries[p2.dataIndex]; return `${e.label}<br>β = ${e.beta.toFixed(4)} · IC95% [${e.lo.toFixed(4)}, ${e.hi.toFixed(4)}]`; } },
          xAxis: { type: 'value', ...AX() },
          yAxis: { type: 'category', data: f.entries.map(e => e.label), ...AX(), splitLine: { show: false } },
          series: [{
            type: 'custom',
            markLine: { silent: true, symbol: 'none', data: [{ xAxis: 0 }], lineStyle: { color: EC.navy, type: 'dashed' }, label: { show: false } },
            renderItem: (params, api) => {
              const beta = api.coord([api.value(0), params.dataIndex]);
              const lo = api.coord([api.value(1), params.dataIndex]);
              const hi = api.coord([api.value(2), params.dataIndex]);
              const color = (api.value(1) > 0 || api.value(2) < 0) ? EC.green : '#888888';
              return { type: 'group', children: [
                { type: 'line', shape: { x1: lo[0], y1: beta[1], x2: hi[0], y2: beta[1] }, style: { stroke: color, lineWidth: 3 } },
                { type: 'circle', shape: { cx: beta[0], cy: beta[1], r: 5.5 }, style: { fill: color } }
              ] };
            },
            data: f.entries.map(e => [e.beta, e.lo, e.hi])
          }]
        };
      }
      if (f.type === 'heatmap') {
        const cells = [];
        f.cells.forEach((row, i) => row.forEach((c, j) => { if (c) cells.push([j, i, c.r, c.sig ? 1 : 0]); }));
        return {
          grid: { left: 10, right: 70, top: 16, bottom: 30, containLabel: true },
          tooltip: { ...tt, formatter: p2 => `${f.countries[p2.data[0]]} · ${f.pairs[p2.data[1]]}<br>r = ${p2.data[2].toFixed(2)}${p2.data[3] ? ' *' : ''}` },
          xAxis: { type: 'category', data: f.countries, ...AX(), splitLine: { show: false }, axisLabel: { color: EC.txt, fontSize: 11 } },
          yAxis: { type: 'category', data: f.pairs, ...AX(), splitLine: { show: false }, axisLabel: { color: EC.txt, fontSize: 10 } },
          visualMap: { min: -1, max: 1, calculable: true, orient: 'vertical', right: 0, top: 'center', textStyle: { color: EC.txt, fontSize: 10 }, inRange: { color: ['#b2182b', '#f7f7f7', '#2166ac'] } },
          series: [{ type: 'heatmap', data: cells, label: { show: true, fontSize: 10, formatter: p2 => p2.data[2].toFixed(2) + (p2.data[3] ? '*' : '') }, itemStyle: { borderColor: '#fff', borderWidth: 1 } }]
        };
      }
      if (f.type === 'box') {
        const q = arr => { const s = [...arr].sort((a, b) => a - b); const p = x => { const i = (s.length - 1) * x, lo = Math.floor(i), hi = Math.ceil(i); return s[lo] + (s[hi] - s[lo]) * (i - lo); }; return [s[0], p(0.25), p(0.5), p(0.75), s[s.length - 1]]; };
        return {
          grid: { left: 80, right: 30, top: 36, bottom: 44 },
          title: { text: `${f.indicator} — dispersión por país`, textStyle: { fontSize: 12, color: '#888', fontWeight: 'normal' }, left: 'center', top: 4 },
          tooltip: { ...tt },
          xAxis: { type: 'category', data: f.countries.map(c => c.cc), ...AX(), splitLine: { show: false } },
          yAxis: { type: 'value', scale: true, ...AX() },
          series: [
            { type: 'boxplot', data: f.countries.map(c => q(c.values)), itemStyle: { color: '#dbe4f5', borderColor: EC.navy } },
            { type: 'scatter', data: f.countries.flatMap((c, i) => c.values.map(v => [i, v])), symbolSize: 5, itemStyle: { color: EC.gold, opacity: 0.6 }, tooltip: { formatter: p2 => `${f.countries[p2.data[0]].cc}: ${p2.data[1].toFixed(2)}` } }
          ]
        };
      }
      if (f.type === 'boot') {
        const centers = f.edges.slice(0, -1).map((e, i) => (e + f.edges[i + 1]) / 2);
        const span = f.edges[f.edges.length - 1] - f.edges[0];
        const xMin = Math.min(f.edges[0], f.ci[0], 0) - span * 0.15, xMax = Math.max(f.edges[f.edges.length - 1], f.ci[1]) + span * 0.15;
        return {
          grid: { left: 60, right: 30, top: 44, bottom: 50 },
          title: [
            { text: '¿Qué tan estable es el resultado?', textStyle: { fontSize: 13, color: '#333', fontWeight: 'bold' }, left: 'center', top: 4 },
            { text: `En 2000 remuestreos el coeficiente de ${f.label} cayó casi siempre en este rango — la banda dorada es el IC95%; si toca la línea roja (cero = sin efecto), es frágil`, textStyle: { fontSize: 10.5, color: '#888', fontWeight: 'normal' }, left: 'center', top: 22 }
          ],
          tooltip: { ...tt, trigger: 'axis' },
          xAxis: { type: 'value', min: xMin, max: xMax, name: 'Coeficiente', nameLocation: 'middle', nameGap: 30, ...AX() },
          yAxis: { type: 'value', name: 'Frecuencia', ...AX() },
          series: [{
            type: 'bar', data: centers.map((c, i) => [c, f.counts[i]]), barCategoryGap: '8%', itemStyle: { color: '#9db4dd', borderColor: EC.navy, borderWidth: 0.5 },
            markArea: { silent: true, itemStyle: { color: 'rgba(184,134,11,0.15)' }, data: [[{ xAxis: f.ci[0] }, { xAxis: f.ci[1] }]] },
            markLine: { silent: true, symbol: 'none', data: [{ xAxis: f.beta, lineStyle: { color: EC.navy, width: 2 }, label: { show: false } }, { xAxis: 0, lineStyle: { color: EC.red, type: 'dashed' }, label: { formatter: 'nulo', position: 'insideStartBottom' } }] }
          }]
        };
      }
      if (f.type === 'resid') {
        return {
          grid: { left: 60, right: 30, top: 36, bottom: 50 },
          title: { text: `Residuos vs ajustados — ${f.dep}`, textStyle: { fontSize: 12, color: '#888', fontWeight: 'normal' }, left: 'center', top: 4 },
          tooltip: { ...tt, formatter: p2 => `${p2.data[2]} — ajustado: ${p2.data[0].toFixed(2)}, residuo: ${p2.data[1].toFixed(2)}` },
          xAxis: { type: 'value', name: 'Valor ajustado', nameLocation: 'middle', nameGap: 30, scale: true, ...AX() },
          yAxis: { type: 'value', name: 'Residuo', nameLocation: 'middle', nameGap: 42, scale: true, ...AX() },
          series: [{ type: 'scatter', data: f.points, symbolSize: 12, itemStyle: { color: EC.blue }, markLine: { silent: true, symbol: 'none', data: [{ yAxis: 0 }], lineStyle: { color: EC.red, type: 'dashed' }, label: { show: false } } }]
        };
      }
      if (f.type === 'panels') {
        const cols = 3, rows = Math.ceil(f.panels.length / cols);
        const w = 100 / cols, h = 100 / rows;
        const grids = [], xAxes = [], yAxes = [], series = [], graphics = [];
        f.panels.forEach((p, i) => {
          const col = i % cols, row = Math.floor(i / cols);
          grids.push({ left: `${col * w + 6}%`, top: `${row * h + 7}%`, width: `${w - 11}%`, height: `${h - 14}%`, show: true, borderColor: '#eee', borderWidth: 1 });
          xAxes.push({ type: 'value', gridIndex: i, scale: true, axisLabel: { fontSize: 9, color: EC.txt }, splitLine: { lineStyle: { color: EC.grid } } });
          yAxes.push({ type: 'value', gridIndex: i, scale: true, axisLabel: { fontSize: 9, color: EC.txt }, splitLine: { lineStyle: { color: EC.grid } } });
          const xs = p.points.map(pt => pt[0]), ys2 = p.points.map(pt => pt[1]);
          const mx = xs.reduce((a, b) => a + b) / xs.length, my = ys2.reduce((a, b) => a + b) / ys2.length;
          let num = 0, den = 0;
          p.points.forEach(pt => { num += (pt[0] - mx) * (pt[1] - my); den += (pt[0] - mx) ** 2; });
          const slope = den ? num / den : 0, intercept = my - slope * mx;
          series.push({ name: p.cc, type: 'scatter', xAxisIndex: i, yAxisIndex: i, data: p.points, symbolSize: 7, itemStyle: { color: EC.blue } });
          series.push({ name: p.cc, type: 'line', xAxisIndex: i, yAxisIndex: i, silent: true, showSymbol: false, tooltip: { show: false }, lineStyle: { width: 1.5, type: 'dashed', color: EC.red }, data: [[Math.min(...xs), slope * Math.min(...xs) + intercept], [Math.max(...xs), slope * Math.max(...xs) + intercept]] });
          graphics.push({ type: 'text', left: `${col * w + 7}%`, top: `${row * h + 8}%`, style: { text: `${p.cc} (β ${slope >= 0 ? '+' : ''}${slope.toFixed(2)})`, fontSize: 11, fill: EC.navy, fontWeight: 'bold' } });
        });
        return {
          title: { text: `${f.y_label} vs ${f.x_label} — por país`, textStyle: { fontSize: 12, color: '#888', fontWeight: 'normal' }, left: 'center', top: 2 },
          tooltip: { ...tt, formatter: p2 => p2.seriesType === 'scatter' ? `${p2.seriesName} ${p2.data[2]}: x=${p2.data[0].toFixed(1)}, y=${p2.data[1].toFixed(1)}` : '' },
          grid: grids, xAxis: xAxes, yAxis: yAxes, series, graphic: graphics
        };
      }
      if (f.type === 'anomaly') {
        return {
          grid: { left: 80, right: 30, top: 36, bottom: 50 },
          title: { text: `${f.label} — años atípicos (|z|>2)`, textStyle: { fontSize: 12, color: '#888', fontWeight: 'normal' }, left: 'center', top: 4 },
          tooltip: { ...tt, trigger: 'axis', formatter: ps => { const p2 = ps[0]; const mk = f.marks.find(m => f.years[p2.dataIndex] === m.year); return `${p2.dataIndex !== undefined ? f.years[p2.dataIndex] : ''}: ${(+p2.value).toFixed(2)}${mk ? ` (z=${mk.z > 0 ? '+' : ''}${mk.z.toFixed(1)})` : ''}`; } },
          xAxis: { type: 'category', data: f.years, name: 'Año', nameLocation: 'middle', nameGap: 28, ...AX(), splitLine: { show: false } },
          yAxis: { type: 'value', scale: true, nameLocation: 'middle', nameGap: 55, ...AX() },
          series: [{
            type: 'line', data: f.values, symbolSize: 8, lineStyle: { width: 2, color: EC.blue }, itemStyle: { color: EC.blue },
            markArea: { silent: true, itemStyle: { color: 'rgba(217,48,37,0.10)' }, data: f.marks.map(m => [{ xAxis: String(m.year) }, { xAxis: String(m.year) }]) },
            markPoint: { data: f.marks.map(m => ({ coord: [String(m.year), f.values[f.years.indexOf(m.year)]], symbol: 'pin', symbolSize: 34, itemStyle: { color: EC.red }, label: { fontSize: 9, color: '#fff', formatter: `z${m.z > 0 ? '+' : ''}${m.z.toFixed(1)}` } })) }
          }]
        };
      }
      return null; // 'trends' u otros: queda el PNG (unidades distintas → mosaico)
    }

    function buildMapOption(f) {
      const vals = f.items.map(i => i.value);
      return {
        title: { text: `${f.indicator} (${f.year})`, textStyle: { fontSize: 12, color: '#888', fontWeight: 'normal' }, left: 'center', top: 4 },
        tooltip: { backgroundColor: '#fff', borderColor: '#ddd', textStyle: { color: '#333', fontSize: 12 }, formatter: p2 => `${p2.name}: ${isNaN(p2.value) ? 's/d' : (+p2.value).toFixed(2)}` },
        visualMap: { min: Math.min(...vals), max: Math.max(...vals), left: 8, bottom: 8, calculable: true, textStyle: { color: EC.txt, fontSize: 10 }, inRange: { color: ['#dbe4f5', '#1a56db', '#14213d'] } },
        series: [{ type: 'map', map: 'world', center: [-70, -15], zoom: 2.6, roam: true, name: f.indicator, itemStyle: { borderColor: '#fff', borderWidth: 0.6, areaColor: '#f2f0ea' }, emphasis: { label: { show: true, fontSize: 10 }, itemStyle: { areaColor: EC.gold } }, data: f.items.map(i => ({ name: i.geo, value: i.value })) }]
      };
    }
