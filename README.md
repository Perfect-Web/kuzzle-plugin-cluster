
# Cluster mode plugin

This plugin adds a cluster mode to Kuzzle.

## Compatiblity

The 1.x version of this plugin are compatible with Kuzzle v1.0.0-RC.8 and upper.

## How to set it up

At the time this document is written, this plugin is working using the following dependencies:

* Kuzzle: >= [1.0.0-RC4 release](https://github.com/kuzzleio/kuzzle/tree/1.0.0-RC4)
* LB: branch [kuz-579-cluster-quarantine](https://github.com/kuzzleio/kuzzle-load-balancer/tree/kuz-579-cluster-quarantine)

```bash
cd <dir>
git pull -b 1.0.0-RC4 git@github.com:kuzzleio/kuzzle.git
git pull -b kuz-579-cluster-quarantine git@github.com:kuzzleio/kuzzle-load-balancer.git
git pull git@github.com:kuzzleio/kuzzle-plugin-cluster.git

cd kuzzle-plugin-cluster
cp docker-compose/my.env.sample docker-compose/my.env
vim docker-compose/my.env

./run-debug.sh
```

You should now have a full Kuzzle clustered stack running 3 Kuzzle front nodes (and 3 servers).

### Privileged context

This plugin needs privileged context to work. This context is granted by Kuzzle via the global configuration. Add the following to your configuration

```javascript
plugins: {
    'kuzzle-plugin-cluster': {
        privileged: true
    }
}
```

For more information on how to configure Kuzzle, [please refer to the Guide](http://docs.kuzzle.io/guide/#configuring-kuzzle).

## Known bugs

* MQ-based functional tests fail


