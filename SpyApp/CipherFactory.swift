import Foundation

struct CipherFactory {

    private var ciphers: [String: Cipher] = [
        "Ceaser": CeaserCipher(),
        "AlphaCeaser": AlphanumericCeaserCipher(),
        "ASCII": ASCIIStarCipher(),
        "Vowel": VowelCipher()
    ]

    func cipher(for key: String) -> Cipher {
        return ciphers[key]!
    }
}
