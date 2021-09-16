import json
from web3 import Web3

RPC = 'http://127.0.0.1:7545'
ABI_PATH = ""
PROXY_ADDRESS = "0xbC363159228eF0A30CEA6b633f297DF13E72511A"
chainId = 5777

w3 = Web3(Web3.HTTPProvider(RPC))


def read_abi(path: str) -> list:
    with open("abi.abi", 'r') as f:
        return json.load(f)

contract = w3.eth.contract(address=PROXY_ADDRESS, abi=read_abi(ABI_PATH))


def set(dest_address: str, private_key: str, amount: int):
    txn = contract.functions.set(Web3.toChecksumAddress(dest_address), amount).buildTransaction({
        'chainId': chainId,
        'gas': 3000000,
        'gasPrice': w3.toWei('1', 'gwei'),
        'nonce': w3.eth.getTransactionCount(Web3.toChecksumAddress(dest_address)),
    })
    signed_txn = w3.eth.account.signTransaction(txn, private_key=private_key)

    w3.eth.sendRawTransaction(signed_txn.rawTransaction)


def get(dest_address: str) -> int:
    return contract.functions.get(Web3.toChecksumAddress(dest_address)).call()
