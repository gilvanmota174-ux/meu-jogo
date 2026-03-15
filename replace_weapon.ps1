$file = "C:\Users\gilva\Documents\Aplicativo de Jogo\jogo.html"
$content = Get-Content $file -Raw
$start = $content.IndexOf("/* ── Arma equipada na mão do personagem ── */`r`nfunction drawEquippedWeapon")
if ($start -lt 0) { $start = $content.IndexOf("/* ── Arma equipada na mão do personagem ── */`nfunction drawEquippedWeapon") }
$end = $content.IndexOf("`n}", $start) + 2
$newFunc = @"

/* ── Arma na mão — chamada dentro do contexto já posicionado na mão ── */
function drawWeaponInHand() {
  const w = selectedWeapon;
  if (w === 'scythe') {
    ctx.strokeStyle='#6D4C41'; ctx.lineWidth=3.5; ctx.lineCap='round';
    ctx.beginPath(); ctx.moveTo(0,4); ctx.lineTo(0,-24); ctx.stroke();
    ctx.strokeStyle='#90A4AE'; ctx.lineWidth=4.5;
    ctx.beginPath(); ctx.moveTo(0,-24); ctx.bezierCurveTo(20,-34,24,-10,10,-6); ctx.stroke();
    ctx.strokeStyle='rgba(200,235,255,0.85)'; ctx.lineWidth=2;
    ctx.beginPath(); ctx.moveTo(0,-24); ctx.bezierCurveTo(18,-32,22,-12,10,-6); ctx.stroke();
  } else if (w === 'axe') {
    ctx.strokeStyle='#6D4C41'; ctx.lineWidth=3.5; ctx.lineCap='round';
    ctx.beginPath(); ctx.moveTo(0,4); ctx.lineTo(0,-22); ctx.stroke();
    ctx.fillStyle='#9E9E9E';
    ctx.beginPath(); ctx.moveTo(-3,-16); ctx.lineTo(-3,-26);
    ctx.lineTo(4,-31); ctx.bezierCurveTo(17,-29,17,-11,4,-9);
    ctx.lineTo(-3,-16); ctx.closePath(); ctx.fill();
    ctx.fillStyle='rgba(230,240,255,0.55)';
    ctx.beginPath(); ctx.moveTo(-1,-17); ctx.lineTo(-1,-24);
    ctx.lineTo(3,-28); ctx.bezierCurveTo(11,-26,11,-13,3,-11);
    ctx.lineTo(-1,-17); ctx.closePath(); ctx.fill();
    ctx.strokeStyle='rgba(255,255,255,0.5)'; ctx.lineWidth=1.5;
    ctx.beginPath(); ctx.moveTo(4,-31); ctx.bezierCurveTo(17,-29,17,-11,4,-9); ctx.stroke();
  } else if (w === 'sword') {
    ctx.strokeStyle='#6D4C41'; ctx.lineWidth=3.5; ctx.lineCap='round';
    ctx.beginPath(); ctx.moveTo(0,4); ctx.lineTo(0,-4); ctx.stroke();
    ctx.strokeStyle='#F9A825'; ctx.lineWidth=4;
    ctx.beginPath(); ctx.moveTo(-9,-4); ctx.lineTo(9,-4); ctx.stroke();
    ctx.fillStyle='#CFD8DC';
    ctx.beginPath(); ctx.moveTo(-3,-4); ctx.lineTo(3,-4); ctx.lineTo(0,-26); ctx.closePath(); ctx.fill();
    ctx.fillStyle='rgba(255,255,255,0.75)';
    ctx.beginPath(); ctx.moveTo(0.5,-4); ctx.lineTo(2.5,-4); ctx.lineTo(0,-26); ctx.closePath(); ctx.fill();
  }
}
"@
$content = $content.Substring(0,$start) + $newFunc + $content.Substring($end)
Set-Content $file $content -NoNewline
Write-Host "Done"
