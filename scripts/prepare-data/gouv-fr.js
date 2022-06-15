const {uniq, isUndefined} = require('lodash')
const {subDays, parseISO, formatISO} = require('date-fns')
const {replaceResourceFile} = require('./datagouv')

function computeLatestDate(records) {
  return uniq(records.map(r => r.date)).sort().pop()
}

function computeOffsetDate(referenceDate, offsetDays) {
  return formatISO(subDays(parseISO(referenceDate), offsetDays), {representation: 'date'})
}

function pickValue(records, name, date, offset) {
  const selectedDate = computeOffsetDate(date, offset)
  const record = records.find(r => r.date === selectedDate)
  return record[name]
}

function computeIndicator(records, name) {
  const recordsWithIndicator = records.filter(r => !isUndefined(r[name]))
  const latestDate = computeLatestDate(recordsWithIndicator)
  return {
    date: latestDate,
    totalDate: pickValue(records, name, latestDate, 0),
    total24h: pickValue(records, name, latestDate, 1),
    total48h: pickValue(records, name, latestDate, 2),
    total7j: pickValue(records, name, latestDate, 7)
  }
}

async function buildGouvFr(records) {
  const recordsFrance = records.filter(r => r.code === 'FRA')

  const data = {
    code: 'FRA',
    nom: 'France',
    casConfirmes: computeIndicator(recordsFrance, 'casConfirmes'),
    deces: computeIndicator(recordsFrance, 'deces'),
    decesEhpad: computeIndicator(recordsFrance, 'decesEhpad'),
    reanimation: computeIndicator(recordsFrance, 'reanimation'),
    hospitalises: computeIndicator(recordsFrance, 'hospitalises'),
    nouvellesHospitalisations: computeIndicator(recordsFrance, 'nouvellesHospitalisations'),
    nouvellesReanimations: computeIndicator(recordsFrance, 'nouvellesReanimations'),
    gueris: computeIndicator(recordsFrance, 'gueris'),
    tauxIncidence: computeIndicator(recordsFrance, 'tauxIncidence'),
    tauxReproductionEffectif: computeIndicator(recordsFrance, 'tauxReproductionEffectif'),
    tauxOccupationRea: computeIndicator(recordsFrance, 'tauxOccupationRea'),
    tauxPositiviteTests: computeIndicator(recordsFrance, 'tauxPositiviteTests')
  }

}

module.exports = {buildGouvFr}
