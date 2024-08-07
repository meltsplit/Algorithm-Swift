import Foundation

func solution(_ w:Int, _ h:Int) -> Int64{
    let origin = w * h
    let removed = (w + h - (gcd(w, h)))
    return Int64(origin - removed)
}

func gcd(_ a: Int, _ b: Int) -> Int {
    return b == 0 ? a : gcd(b, a % b)
}