//Q1
export function all<T>(promises : Array<Promise<T>>) : Promise<Array<T>> {
  return new Promise<T[]>((resolve, reject) => {
    const results: T[] = [];
    let remaining = promises.length;

    if (remaining === 0) {
      resolve(results);
      return;
    }

    promises.forEach((p, index) => {
      p.then((value) => {
        results[index] = value;
        remaining -= 1;
        if (remaining === 0) {
          resolve(results);
        }
      }).catch(reject);
    });
  });
}

  
// Q2
export function* Fib1() {
  let a = 1;
  let b = 1;
  while (true) {
    yield a;
    const next = a + b;
    a = b;
    b = next;
  }
}


export function* Fib2() {
  const sqrt5 = Math.sqrt(5);
  const phi = (1 + sqrt5) / 2;
  const psi = (1 - sqrt5) / 2;
  let n = 1;
  while (true) {
    const val = Math.round((Math.pow(phi, n) - Math.pow(psi, n)) / sqrt5);
    yield val;
    n += 1;
  }
}
