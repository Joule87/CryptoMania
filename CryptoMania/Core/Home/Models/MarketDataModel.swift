//
//  MarketDataModel.swift
//  CryptoMania
//
//  Created by Julio Collado on 13/11/21.
//

import Foundation

/*
 URL: https://api.coingecko.com/api/v3/global

 JSON:
 {
   "data": {
     "active_cryptocurrencies": 10684,
     "upcoming_icos": 0,
     "ongoing_icos": 50,
     "ended_icos": 3375,
     "markets": 677,
     "total_market_cap": {
       "btc": 45948525.35391811,
       "eth": 633894611.795942,
       "ltc": 11780893851.395998,
       "bch": 4446770132.804679,
       "bnb": 4662224484.8319435,
       "eos": 598502889795.8767,
       "xrp": 2473055193405.694,
       "xlm": 7779717061466.537,
       "link": 87604647031.68422,
       "dot": 64254704598.39258,
       "yfi": 89201970.91665807,
       "usd": 2936191763402.1816,
       "aed": 10784632346976.21,
       "ars": 294312881006239.44,
       "aud": 4004325475476.1543,
       "bdt": 251904682340412.97,
       "bhd": 1107775237071.6675,
       "bmd": 2936191763402.1816,
       "brl": 16029258074765.174,
       "cad": 3685273006081.3467,
       "chf": 2704673042857.9204,
       "clp": 2351537259473541.5,
       "cny": 18731728973800.547,
       "czk": 64779730780060.87,
       "dkk": 19081282603233.59,
       "eur": 2565738320997.254,
       "gbp": 2188737170959.9443,
       "hkd": 22875958114419.293,
       "huf": 941563293728996.2,
       "idr": 41668084552793020,
       "ils": 9130000202546.17,
       "inr": 218326557760884.44,
       "jpy": 334518859508529,
       "krw": 3464544790267588.5,
       "kwd": 888015964539.827,
       "lkr": 593229892741384.5,
       "mmk": 5220963028836337,
       "mxn": 60252123080894.64,
       "myr": 12228651456217.404,
       "ngn": 1205541614217669.5,
       "nok": 25526320418229.562,
       "nzd": 4167985868176.4297,
       "php": 146310435570330.88,
       "pkr": 507080317539558.25,
       "pln": 11901004753531.121,
       "rub": 214046911456137.25,
       "sar": 11012052143818.748,
       "sek": 25710587004725.41,
       "sgd": 3972432560542.081,
       "thb": 96292720117101.44,
       "try": 29322000106998.39,
       "twd": 81615267113056.08,
       "uah": 76827530440802.97,
       "vef": 294000881269.46027,
       "vnd": 66520689927888430,
       "zar": 44964429597894.13,
       "xdr": 2090257299215.4338,
       "xag": 116004649732.04588,
       "xau": 1574738366.5478582,
       "bits": 45948525353918.11,
       "sats": 4594852535391811
     },
     "total_volume": {
       "btc": 2105265.8844998837,
       "eth": 29043732.966470435,
       "ltc": 539776058.6051873,
       "bch": 203741760.6919658,
       "bnb": 213613431.07738656,
       "eos": 27422157859.401463,
       "xrp": 113310246391.14575,
       "xlm": 356450458298.9968,
       "link": 4013862758.355792,
       "dot": 2944016950.8743267,
       "yfi": 4087048.8172255903,
       "usd": 134530200963.52368,
       "aed": 494129428139.02246,
       "ars": 13484804201632.006,
       "aud": 183469866530.43628,
       "bdt": 11541748724082.39,
       "bhd": 50755957810.12121,
       "bmd": 134530200963.52368,
       "brl": 734427273100.0679,
       "cad": 168851545833.33786,
       "chf": 123922494617.5499,
       "clp": 107742547347666.95,
       "cny": 858248870066.8953,
       "czk": 2968072558757.752,
       "dkk": 874264690491.6034,
       "eur": 117556794568.35777,
       "gbp": 100283385825.04344,
       "hkd": 1048128831612.8418,
       "huf": 43140472193978.03,
       "idr": 1909144987913556.8,
       "ils": 418317623990.0475,
       "inr": 10003268879554.791,
       "jpy": 15326958530673.777,
       "krw": 158738237975905.03,
       "kwd": 40687044919.00609,
       "lkr": 27180560099247.35,
       "mmk": 239213669300206.53,
       "mxn": 2760626988871.9956,
       "myr": 560291380972.8834,
       "ngn": 55235409911603.64,
       "nok": 1169562921103.1694,
       "nzd": 190968445401.9422,
       "php": 6703639914012.394,
       "pkr": 23233365706400.61,
       "pln": 545279290377.5648,
       "rub": 9807184385140.39,
       "sar": 504549330324.45044,
       "sek": 1178005632925.0378,
       "sgd": 182008599487.57056,
       "thb": 4411932200800.06,
       "try": 1343473071553.1392,
       "twd": 3739441825042.3945,
       "uah": 3520077686532.474,
       "vef": 13470509022.47762,
       "vnd": 3047839686690549.5,
       "zar": 2060176663327.2668,
       "xdr": 95771242884.72678,
       "xag": 5315091825.975426,
       "xau": 72151237.38075703,
       "bits": 2105265884499.8838,
       "sats": 210526588449988.38
     },
     "market_cap_percentage": {
       "btc": 41.07184257740441,
       "eth": 18.671419077729183,
       "bnb": 3.6077469285348065,
       "usdt": 2.5561807328089925,
       "sol": 2.346193613437602,
       "ada": 2.2416531807644726,
       "xrp": 1.9123172851019448,
       "dot": 1.6351545946573474,
       "usdc": 1.1778926484142098,
       "doge": 1.167471909186014
     },
     "market_cap_change_percentage_24h_usd": 0.4072428260765233,
     "updated_at": 1636802274
   }
 }
*/

// MARK: - Welcome
struct GlobalData: Codable {
    let data: MarketDataModel?
}

// MARK: - DataClass
struct MarketDataModel: Codable {
    let totalMarketCap, totalVolume, marketCapPercentage: [String: Double]
    let marketCapChangePercentage24HUsd: Double
    
    var marketCap: String {
        if let item = totalMarketCap.first(where: { $0.key == "usd"}) {
            return "$ " + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var volume: String {
        if let item = totalVolume.first(where: { $0.key == "usd"}) {
            return "$ " + item.value.formattedWithAbbreviations()
        }
        return ""
    }
    
    var btcDominance: String {
        if let item = marketCapPercentage.first(where: { $0.key == "btc"}) {
            return item.value.asPercentString
        }
        return ""
    }

    enum CodingKeys: String, CodingKey {
        case totalMarketCap = "total_market_cap"
        case totalVolume = "total_volume"
        case marketCapPercentage = "market_cap_percentage"
        case marketCapChangePercentage24HUsd = "market_cap_change_percentage_24h_usd"
    }
}
