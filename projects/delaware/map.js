const canvas = document.querySelector('#district-map');
const picker = document.querySelector('#district');
const context = canvas.getContext('2d');
const paths = [];
const width = canvas.width;
const height = canvas.height;

function draw() {
  context.clearRect(0, 0, width, height);
  for (const {name, shape} of paths) {
    context.fillStyle = name === picker.value ? '#b66816' : '#447477';
    context.fill(shape, 'evenodd');
    context.strokeStyle = '#faf9f5';
    context.lineWidth = 1.3;
    context.stroke(shape);
  }
}

async function loadDistricts() {
  const response = await fetch('districts.geojson');
  if (!response.ok) throw new Error('District shapes unavailable');
  const {features} = await response.json();
  const polygons = features.map(({geometry}) => geometry.type === 'Polygon' ? [geometry.coordinates] : geometry.coordinates);
  const points = polygons.flat(3);
  const xs = points.map(p => p[0] * Math.cos(39 * Math.PI / 180));
  const ys = points.map(p => p[1]);
  const left = Math.min(...xs), top = Math.max(...ys);
  const dx = Math.max(...xs) - left, dy = top - Math.min(...ys);
  const scale = Math.min((width-32)/dx, (height-32)/dy);
  for (const [index, group] of polygons.entries()) {
    const shape = new Path2D();
    for (const polygon of group) {
      for (const ring of polygon) {
        ring.forEach(([lon, lat], i) => {
          const x = (width-dx*scale)/2 + (lon*Math.cos(39*Math.PI/180)-left)*scale;
          const y = (height-dy*scale)/2 + (top-lat)*scale;
          if (i === 0) shape.moveTo(x,y); else shape.lineTo(x,y);
        });
        shape.closePath();
      }
    }
    paths.push({name: features[index].properties.district, shape});
  }
  draw();
  canvas.addEventListener('click', event => {
    const rect = canvas.getBoundingClientRect();
    const x = (event.clientX-rect.left)*width/rect.width;
    const y = (event.clientY-rect.top)*height/rect.height;
    const found = paths.find(({shape}) => context.isPointInPath(shape, x, y, 'evenodd'));
    if (found) { picker.value = found.name; picker.dispatchEvent(new Event('change')); }
  });
  picker.addEventListener('change', draw);
}
loadDistricts().catch(() => { canvas.hidden = true; });
