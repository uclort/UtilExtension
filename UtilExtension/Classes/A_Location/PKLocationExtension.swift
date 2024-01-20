//
//  PKLocationExtension.swift
//  BaseExtension
//
//  Created by 侯猛 on 2023/2/24.
//

import Foundation
import MapKit

private let a = 6378245.0
private let ee = 0.00669342162296594323
private let pi = 3.14159265358979324
private let xPi = Double.pi * 3000.0 / 180.0

public extension UclortExtensionUtil where Util == CLLocationCoordinate2D {
    /// 判断是否超出中国区域
    /// - Parameter location: 经纬度
    /// - Returns: 返回 true 代表超出中国，false 代表在中国境内
    func isLocationOutChina() -> Bool {
        util.longitude < 72.004 || util.longitude > 137.847 || util.latitude < 0.8293 || util.latitude > 55.8271
    }

    /// 将 WGS-84 (国际标准 GPS) 转为 GCJ-02 (火星坐标)
    func WGS84ToGCJ02() -> CLLocationCoordinate2D {
        let wgsLoc = util
        var adjustLoc = CLLocationCoordinate2D()
        if wgsLoc.util.isLocationOutChina() {
            adjustLoc = wgsLoc
        }
        else {
            var adjustLat = transformLatWith(x: wgsLoc.longitude - 105.0, y: wgsLoc.latitude - 35.0)
            var adjustLon = transformLonWith(x: wgsLoc.longitude - 105.0, y: wgsLoc.latitude - 35.0)
            let radLat = wgsLoc.latitude / 180.0 * pi
            var magic = sin(radLat)
            magic = 1 - ee * magic * magic
            let sqrtMagic = sqrt(magic)
            adjustLat = (adjustLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * pi)
            adjustLon = (adjustLon * 180.0) / (a / sqrtMagic * cos(radLat) * pi)
            adjustLoc.latitude = wgsLoc.latitude + adjustLat
            adjustLoc.longitude = wgsLoc.longitude + adjustLon
        }
        return adjustLoc
    }

    /// 将 GCJ-02 (火星坐标) 转为百度坐标
    func GCJ02ToBD09() -> CLLocationCoordinate2D {
        let gcjLoc = util
        let z = sqrt(gcjLoc.longitude * gcjLoc.longitude + gcjLoc.latitude * gcjLoc.latitude) + 0.00002 * sin(gcjLoc.latitude * xPi)
        let theta = atan2(gcjLoc.latitude, gcjLoc.longitude) + 0.000003 * cos(gcjLoc.longitude * xPi)
        var geoPoint = CLLocationCoordinate2D()
        geoPoint.latitude = (z * sin(theta) + 0.006)
        geoPoint.longitude = (z * cos(theta) + 0.0065)
        return geoPoint
    }

    /// 将百度坐标转为 GCJ-02 (火星坐标)
    func BD09ToGCJ02() -> CLLocationCoordinate2D {
        let bdLoc = util
        let x = bdLoc.longitude - 0.0065, y = bdLoc.latitude - 0.006
        let z = sqrt(x * x + y * y) - 0.00002 * sin(y * xPi)
        let theta = atan2(y, x) - 0.000003 * cos(x * xPi)
        var geoPoint = CLLocationCoordinate2D()
        geoPoint.latitude = z * sin(theta)
        geoPoint.longitude = z * cos(theta)
        return geoPoint
    }

    /// 将 GCJ-02 (火星坐标)转为 WGS-84 (国际标准 GPS)
    func GCJ02ToWGS84() -> CLLocationCoordinate2D {
        let gcjLoc = util
        let threshold = 0.00001

        var minLat = gcjLoc.latitude - 0.5
        var maxLat = gcjLoc.latitude + 0.5
        var minLng = gcjLoc.longitude - 0.5
        var maxLng = gcjLoc.longitude + 0.5

        var delta = 1.0
        let maxIteration = 30
        while true {
            let leftBottom = CLLocationCoordinate2DMake(minLat, minLng).util.WGS84ToGCJ02()
            let rightBottom = CLLocationCoordinate2DMake(minLat, maxLng).util.WGS84ToGCJ02()
            let leftUp = CLLocationCoordinate2DMake(maxLat, minLng).util.WGS84ToGCJ02()
            let midPoint = CLLocationCoordinate2DMake((minLat + maxLat) / 2.0, (minLng + maxLng) / 2.0).util.WGS84ToGCJ02()
            delta = fabs(midPoint.latitude - gcjLoc.latitude) + fabs(midPoint.longitude - gcjLoc.longitude)

            if maxIteration - 1 <= 0 || delta <= threshold {
                return CLLocationCoordinate2DMake((minLat + maxLat) / 2.0, (minLng + maxLng) / 2.0)
            }

            if isContains(gcjLoc, leftBottom, midPoint) {
                maxLat = (minLat + maxLat) / 2.0
                maxLng = (minLng + maxLng) / 2.0
            }
            else if isContains(gcjLoc, rightBottom, midPoint) {
                maxLat = (minLat + maxLat) / 2.0
                minLng = (minLng + maxLng) / 2.0
            }
            else if isContains(gcjLoc, leftUp, midPoint) {
                minLat = (minLat + maxLat) / 2.0
                maxLng = (minLng + maxLng) / 2.0
            }
            else {
                minLat = (minLat + maxLat) / 2.0
                minLng = (minLng + maxLng) / 2.0
            }
        }
    }

    /// 获取两点之间的距离 m
    static func distanceByPoint(_ coordinate1: CLLocationCoordinate2D, _ coordinate2: CLLocationCoordinate2D) -> Double {
        let dd = pi / 180
        let x1 = coordinate1.latitude * dd
        let x2 = coordinate2.latitude * dd
        let y1 = coordinate1.longitude * dd
        let y2 = coordinate2.longitude * dd
        let R = 6371004

        let temp = 2 - 2 * cos(x1) * cos(x2) * cos(y1 - y2) - 2 * sin(x1) * sin(x2)

        let distance = Double(2) * Double(R) * asin(sqrt(temp) / 2)

        // 返回 m
        return distance
    }

    private func isContains(_ point: CLLocationCoordinate2D, _ p1: CLLocationCoordinate2D, _ p2: CLLocationCoordinate2D) -> Bool {
        return (point.latitude >= min(p1.latitude, p2.latitude) && point.latitude <= max(p1.latitude, p2.latitude)) && (point.longitude >= min(p1.longitude, p2.longitude) && point.longitude <= max(p1.longitude, p2.longitude))
    }

    private func transformLatWith(x: Double, y: Double) -> Double {
        var lat = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x))
        lat += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0
        lat += (20.0 * sin(y * pi) + 40.0 * sin(y / 3.0 * pi)) * 2.0 / 3.0
        lat += (160.0 * sin(y / 12.0 * pi) + 320 * sin(y * pi / 30.0)) * 2.0 / 3.0
        return lat
    }

    private func transformLonWith(x: Double, y: Double) -> Double {
        var lon = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x))
        lon += (20.0 * sin(6.0 * x * pi) + 20.0 * sin(2.0 * x * pi)) * 2.0 / 3.0
        lon += (20.0 * sin(x * pi) + 40.0 * sin(x / 3.0 * pi)) * 2.0 / 3.0
        lon += (150.0 * sin(x / 12.0 * pi) + 300.0 * sin(x / 30.0 * pi)) * 2.0 / 3.0
        return lon
    }
}
