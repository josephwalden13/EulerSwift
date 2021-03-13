//
//  ContentView.swift
//  EulerSwift
//
//  Created by Joseph Walden on 11/03/2021.
//

import SwiftUI

struct Problems {
    
    public static var problems:[([String], () -> String)] = [
        (["Problem 1", "Find the sum of all the multiples of 3 or 5 below 1000."], problem001),
        (["Problem 2", "By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms."], problem002),
        (["Problem 3", "What is the largest prime factor of the number 600851475143?"], problem003),
        (["Problem 4", "Find the largest palindrome made from the product of two 3-digit numbers."], problem004),
        (["Problem 5", "What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?"], problem005),
        (["Problem 6", "Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum."], problem006),
        (["Problem 7", "What is the 10001st prime number?"], problem007),
        (["Problem 8", "Find the thirteen adjacent digits in the 1000-digit number that have the greatest product. What is the value of this product?"], problem008),
        (["Problem 9", "There exists exactly one Pythagorean triplet for which a + b + c = 1000.\nFind the product abc."], problem009),
        (["Problem 10", "Find the sum of all the primes below two million."], problem010),
        //(["Problem 11", "What is the greatest product of four adjacent numbers in the same direction (up, down, left, right, or diagonally) in the 20×20 grid?"], problem011),
        //(["Problem 12", "What is the value of the first triangle number to have over five hundred divisors?"], problem012),
        (["Problem 13", "Work out the first ten digits of the sum of the following one-hundred 50-digit numbers."], problem013)
    ]
    static func problem001() -> String {
        var index = 3;
        var sum = 0;
        while (index < 1000) {
            if (index % 3 == 0 || index % 5 == 0) {
                sum += index
            }
            index += 1
        }
        return String(sum)
    }
    static func problem002() -> String {
        var sum:Int = 0
        for i in EulerMaths.fibonacci(max: 4000000) {
            if i % 2 == 0 {
                sum += i
            }
        }
        return String(sum)
    }
    static func problem003() -> String {
        let factors = EulerMaths.primeFactors(n: 600851475143)
        return String(factors.last!)
    }
    static func problem004() -> String {
        var largest:Int = 0
        for i in 900 ..< 1000 {
            for j in 900 ..< 1000 {
                let product = i * j
                if EulerMaths.isPalindrome(n: product) {
                    if product > largest {
                        largest = product
                    }
                }
            }
        }
        return String(largest)
    }
    static func problem005() -> String {
        var index = 11 * 13 * 17 * 19 * 20 //use 20 * primes (11 <= x <= 19)
        let numbers:[Int] = [20, 19, 18, 17, 16, 15, 14, 13, 12, 11] //only needs to check 11-20 to save time
        while !EulerMaths.divisible(byArray: numbers, n: index) {
            index += 11 * 13 * 17 * 19 * 20 //use 20 * primes (11 <= x <= 19)
        }
        return String(index)
    }
    static func problem006() -> String {
        var sum:Int = 0
        var sumSquares:Int = 0
        for i in 1...100 {
            sum += i
            sumSquares += Int(pow(Double(i), 2))
        }
        let diff = Int(pow(Double(sum), 2)) - sumSquares
        return String(diff)
    }
    static func problem007() -> String {
        let p = EulerMaths.primes(n: 1000000) //assuming the 10001st prime is less than 1e6
        return String(p[10000])
    }
    static func problem008() -> String {
        let massiveNumber:String = "7316717653133062491922511967442657474235534919493496983520312774506326239578318016984801869478851843858615607891129494954595017379583319528532088055111254069874715852386305071569329096329522744304355766896648950445244523161731856403098711121722383113622298934233803081353362766142828064444866452387493035890729629049156044077239071381051585930796086670172427121883998797908792274921901699720888093776657273330010533678812202354218097512545405947522435258490771167055601360483958644670632441572215539753697817977846174064955149290862569321978468622482839722413756570560574902614079729686524145351004748216637048440319989000889524345065854122758866688116427171479924442928230863465674813919123162824586178664583591245665294765456828489128831426076900422421902267105562632111110937054421750694165896040807198403850962455444362981230987879927244284909188845801561660979191338754992005240636899125607176060588611646710940507754100225698315520005593572972571636269561882670428252483600823257530420752963450"
        if massiveNumber.count != 1000 {
            return "I think you typo'd the number :("
        }
        var largestProduct = 0
        for i in 0 ... 1000 - 13 {
            var tempProduct = 1
            for j in i ..< i + 13 {
                let strIndex = massiveNumber.index(massiveNumber.startIndex, offsetBy: j)
                let c = massiveNumber[strIndex]
                let n = c.wholeNumberValue!
                tempProduct *= n
            }
            if tempProduct > largestProduct {
                largestProduct = tempProduct
            }
        }
        return String(largestProduct)
    }
    static func problem009() -> String {
        for a in 200 ... 500 {
            for b in 200 ... 500 {
                for c in 200 ... 500 { //best guess at a reasonable range
                    if a > b || b > c { // a < b < c
                        continue
                    }
                    if (a * a + b * b == c * c) {
                        //triplet
                        if (a + b + c == 1000) {
                            return String(a * b * c)
                        }
                    }
                }
            }
        }
        return "Failed to find"
    }
    static func problem010() -> String {
        return String(EulerMaths.sum(of: EulerMaths.primes(n: 2000000)))
    }
    static func problem011() -> String {
        return ""
    }
    static func problem012() -> String {
        return ""
    }
    static func problem013() -> String {
        var numbers = ["37107287533902102798797998220837590246510135740250",
                       "46376937677490009712648124896970078050417018260538",
                       "74324986199524741059474233309513058123726617309629",
                       "91942213363574161572522430563301811072406154908250",
                       "23067588207539346171171980310421047513778063246676",
                       "89261670696623633820136378418383684178734361726757",
                       "28112879812849979408065481931592621691275889832738",
                       "44274228917432520321923589422876796487670272189318",
                       "47451445736001306439091167216856844588711603153276",
                       "70386486105843025439939619828917593665686757934951",
                       "62176457141856560629502157223196586755079324193331",
                       "64906352462741904929101432445813822663347944758178",
                       "92575867718337217661963751590579239728245598838407",
                       "58203565325359399008402633568948830189458628227828",
                       "80181199384826282014278194139940567587151170094390",
                       "35398664372827112653829987240784473053190104293586",
                       "86515506006295864861532075273371959191420517255829",
                       "71693888707715466499115593487603532921714970056938",
                       "54370070576826684624621495650076471787294438377604",
                       "53282654108756828443191190634694037855217779295145",
                       "36123272525000296071075082563815656710885258350721",
                       "45876576172410976447339110607218265236877223636045",
                       "17423706905851860660448207621209813287860733969412",
                       "81142660418086830619328460811191061556940512689692",
                       "51934325451728388641918047049293215058642563049483",
                       "62467221648435076201727918039944693004732956340691",
                       "15732444386908125794514089057706229429197107928209",
                       "55037687525678773091862540744969844508330393682126",
                       "18336384825330154686196124348767681297534375946515",
                       "80386287592878490201521685554828717201219257766954",
                       "78182833757993103614740356856449095527097864797581",
                       "16726320100436897842553539920931837441497806860984",
                       "48403098129077791799088218795327364475675590848030",
                       "87086987551392711854517078544161852424320693150332",
                       "59959406895756536782107074926966537676326235447210",
                       "69793950679652694742597709739166693763042633987085",
                       "41052684708299085211399427365734116182760315001271",
                       "65378607361501080857009149939512557028198746004375",
                       "35829035317434717326932123578154982629742552737307",
                       "94953759765105305946966067683156574377167401875275",
                       "88902802571733229619176668713819931811048770190271",
                       "25267680276078003013678680992525463401061632866526",
                       "36270218540497705585629946580636237993140746255962",
                       "24074486908231174977792365466257246923322810917141",
                       "91430288197103288597806669760892938638285025333403",
                       "34413065578016127815921815005561868836468420090470",
                       "23053081172816430487623791969842487255036638784583",
                       "11487696932154902810424020138335124462181441773470",
                       "63783299490636259666498587618221225225512486764533",
                       "67720186971698544312419572409913959008952310058822",
                       "95548255300263520781532296796249481641953868218774",
                       "76085327132285723110424803456124867697064507995236",
                       "37774242535411291684276865538926205024910326572967",
                       "23701913275725675285653248258265463092207058596522",
                       "29798860272258331913126375147341994889534765745501",
                       "18495701454879288984856827726077713721403798879715",
                       "38298203783031473527721580348144513491373226651381",
                       "34829543829199918180278916522431027392251122869539",
                       "40957953066405232632538044100059654939159879593635",
                       "29746152185502371307642255121183693803580388584903",
                       "41698116222072977186158236678424689157993532961922",
                       "62467957194401269043877107275048102390895523597457",
                       "23189706772547915061505504953922979530901129967519",
                       "86188088225875314529584099251203829009407770775672",
                       "11306739708304724483816533873502340845647058077308",
                       "82959174767140363198008187129011875491310547126581",
                       "97623331044818386269515456334926366572897563400500",
                       "42846280183517070527831839425882145521227251250327",
                       "55121603546981200581762165212827652751691296897789",
                       "32238195734329339946437501907836945765883352399886",
                       "75506164965184775180738168837861091527357929701337",
                       "62177842752192623401942399639168044983993173312731",
                       "32924185707147349566916674687634660915035914677504",
                       "99518671430235219628894890102423325116913619626622",
                       "73267460800591547471830798392868535206946944540724",
                       "76841822524674417161514036427982273348055556214818",
                       "97142617910342598647204516893989422179826088076852",
                       "87783646182799346313767754307809363333018982642090",
                       "10848802521674670883215120185883543223812876952786",
                       "71329612474782464538636993009049310363619763878039",
                       "62184073572399794223406235393808339651327408011116",
                       "66627891981488087797941876876144230030984490851411",
                       "60661826293682836764744779239180335110989069790714",
                       "85786944089552990653640447425576083659976645795096",
                       "66024396409905389607120198219976047599490197230297",
                       "64913982680032973156037120041377903785566085089252",
                       "16730939319872750275468906903707539413042652315011",
                       "94809377245048795150954100921645863754710598436791",
                       "78639167021187492431995700641917969777599028300699",
                       "15368713711936614952811305876380278410754449733078",
                       "40789923115535562561142322423255033685442488917353",
                       "44889911501440648020369068063960672322193204149535",
                       "41503128880339536053299340368006977710650566631954",
                       "81234880673210146739058568557934581403627822703280",
                       "82616570773948327592232845941706525094512325230608",
                       "22918802058777319719839450180888072429661980811197",
                       "77158542502016545090413245809786882778948721859617",
                       "72107838435069186155435662884062257473692284509516",
                       "20849603980134001723930671666823555245252804609722",
                       "53503534226472524250874054075591789781264330331690"]
        do {
            var num = try BigNumber(number: "0")
            for i in numbers {
                let temp = try BigNumber(number: i)
                num = num + temp
            }
            let str = num.toString()
            return str.substring(to: str.index(str.startIndex, offsetBy: 10))
        }
        catch {
            return "Something went wrong"
        }
    }
}

struct AllView: View {
    @State var showResult:Bool = false
    @State var result:String = ""
    var body: some View {
        Form {
            ForEach (Problems.problems, id: \.0) {
                x in
                DisclosureGroup(
                    content: { Text(x.0[1]) },
                    label: { Button(x.0[0]) {
                        let start = DispatchTime.now()
                        let answer = x.1()
                        let end = DispatchTime.now()
                        let timeInterval = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1e6 //ms
                        result = String(format: "\(answer) - Took %.3fms", timeInterval)
                        showResult = true;
                    } })
                
            }.alert(isPresented: $showResult, content: {
                Alert(title: Text(result))
            })
        }
    }
}

struct SlowView: View {
    @State var showResult:Bool = false
    @State var result:String = ""
    @State var problems:[([String], () -> String)] = []
    var body: some View {
        Form {
            Text("May take some time to start displaying problems. Displaying problems which take over 250ms to compute")
            ForEach (problems, id: \.0) {
                x in
                DisclosureGroup(
                    content: { Text(x.0[1]) },
                    label: { Button(x.0[0]) {
                        let start = DispatchTime.now()
                        let answer = x.1()
                        let end = DispatchTime.now()
                        let timeInterval = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1e6 //ms
                        result = String(format: "\(answer) - Took %.3fms", timeInterval)
                        showResult = true;
                    } })
                
            }.alert(isPresented: $showResult, content: {
                Alert(title: Text(result))
            })
        }.onAppear {
            problems = []
            DispatchQueue.main.async {
                for i in Problems.problems {
                    let start = DispatchTime.now()
                    _ = i.1()
                    let end = DispatchTime.now()
                    let timeInterval = Double(end.uptimeNanoseconds - start.uptimeNanoseconds) / 1e6 //ms
                    if timeInterval > 250 {
                        problems.append(i)
                    }
                }
            }
        }
    }
}

struct ContentView: View {
    var body: some View {
        NavigationView {
            TabView {
                AllView().tabItem { Label("All Problems", systemImage: "house") }
                SlowView().tabItem { Label("Slow Problems", systemImage: "tortoise")}
            }.navigationTitle("Project Eueler")
        }
    }
}
