import Foundation

protocol Cipher {
    func encode(_ plaintext: String, secret: String) -> String
    func decrypt(_ plaintext: String, secret: String) -> String
}



struct CeaserCipher: Cipher {
    
    func encode(_ plaintext: String, secret: String) -> String {
        var encoded = ""
        var shiftBy = UInt32()
        if secret != nil{
            shiftBy = UInt32(secret)!
        }
        else{
            print("Please enter a secret value")
        }
        
        for character in plaintext {
            let unicode = character.unicodeScalars.first!.value
            let shiftedUnicode = unicode + shiftBy
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            encoded = encoded + shiftedCharacter
        }
        return encoded
    }
    func decrypt(_ plaintext: String, secret: String) -> String {
        var decoded = ""
        var shiftBy = UInt32(secret)!
        
        for character in plaintext {
            let unicode = character.unicodeScalars.first!.value
            let shiftedUnicode = unicode - shiftBy
            let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
            decoded = decoded + shiftedCharacter
        }
        return decoded
    }
    
}



struct AlphanumericCeaserCipher: Cipher {
    
    func encode(_ plaintext: String, secret: String) -> String {
        var encoded = ""
        var upperplaintext = ""
        let shiftBy = UInt32(secret)!
        var value = UInt32()
        upperplaintext = plaintext.uppercased()
        for character in upperplaintext {
            let unicode = character.unicodeScalars.first!.value
            if unicode > 64 && unicode < 91{
                value = unicode - 64 + shiftBy
            }
            else if unicode > 47 && unicode < 58{
                value = unicode - 47 + 26 + shiftBy
            }
            
            if value > 36{
                value = value % 36
            }
            if (value > 0 && value < 27) {
                let shiftedUnicode = value + 64
                let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
                encoded = encoded + shiftedCharacter
            }
            else if (value > 26 && value < 37){
                value = value - 26
                let shiftedUnicode = value + 47
                let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
                encoded = encoded + shiftedCharacter
            }
            
            
        }
        return encoded
    }
    
    func decrypt(_ plaintext: String, secret: String) -> String {
        var decoded = ""
        let shiftBy = Int32(secret)!
        var upperplaintext = ""
        var value = Int32()
        upperplaintext = plaintext.uppercased()
        for character in upperplaintext {
            let unicode = character.unicodeScalars.first!.value
            let uniInt = Int32(unicode)
            if unicode > 64 && unicode < 91{
                value = uniInt - 64 - shiftBy
            }
            else if unicode > 47 && unicode < 58{
                value = uniInt - 47 + 26 - shiftBy
            }
            while value < 1{
                value = value + 36
            }
            if value > 36{
                value = value % 36
            }
            if (value > 0 && value < 27) {
                let shiftedUnicode = value + 64
                let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
                decoded = decoded + shiftedCharacter
            }
            else if (value > 26 && value < 37){
                let shiftedUnicode = value + 47 - 26
                let shiftedCharacter = String(UnicodeScalar(UInt8(shiftedUnicode)))
                decoded = decoded + shiftedCharacter
            }
        }
        return decoded
    }
}

struct ASCIIStarCipher: Cipher {
    
    //Encodes any string to ascii value followed by an *, decodes back to original string
    
    func encode(_ plaintext: String, secret: String) -> String {
        var encoded = ""
        
        for character in plaintext {
            let unicode = character.unicodeScalars.first!.value
            
            encoded = encoded + String(unicode) + "*"
        }
        return encoded
    }
    func decrypt(_ plaintext: String, secret: String) -> String {
        var decoded = ""
        var block = ""
        
        for character in plaintext {
            if character == "*"{
                let ascii = block
                let shiftedCharacter = String(UnicodeScalar(UInt8(ascii)!))
                decoded = decoded + shiftedCharacter
                block = ""
                continue;
            }
            else{
                block = block + String(character)
            }
            
        }
        return decoded
    }
    
}

struct VowelCipher: Cipher {
    // Takes a word and encrypts it by shifting the first value to the end and then reversing the word
    //and appending a number that indicates the position of the first vowel
    func encode(_ plaintext: String, secret: String) -> String {
        var encoded = ""
        var upperplaintext = ""
        var hold = ""
        var shifted = false
        var count = 0
        var vowel = ""
        upperplaintext = plaintext.uppercased()
        for character in upperplaintext {
            if shifted == false{
                if character == "A" || character == "E" || character == "I" || character == "O" || character == "U" {
                    vowel = String(character)
                    shifted = true
                }
                else{
                    hold = hold + String(character)
                    count += 1
                }
            }
            else{
                encoded = encoded + String(character)
                
            }
        }
        if encoded == ""{
            let reversed = String(hold.reversed())
            encoded = reversed
        }
        else{
            encoded = vowel + hold + encoded
            let reversed = String(encoded.reversed())
            encoded = reversed
            encoded = String(count) + encoded
        }
        return encoded
    }
    func decrypt(_ plaintext: String, secret: String) -> String {
        var decoded = ""
        var upperplaintext = ""
        var count = 0
        upperplaintext = plaintext.uppercased()
        
        let vowel = upperplaintext.unicodeScalars.last!.value
        var stop = UInt32()
        stop = upperplaintext.unicodeScalars.first!.value
        stop = stop - 48
        let modString = String(upperplaintext.dropLast().dropFirst())
        let superModString = modString.reversed()
        print(superModString)
        
        for character in superModString {
        
            if count == stop{
                decoded = decoded + String(UnicodeScalar(UInt8(vowel)))
                decoded = decoded + String(character)
                count += 1
            }
            else{
                decoded = decoded + String(character)
                count += 1
            }
            
            
            
        }
        return decoded
    }
}

