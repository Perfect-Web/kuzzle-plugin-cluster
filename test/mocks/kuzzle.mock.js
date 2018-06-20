/*
 * Kuzzle, a backend software, self-hostable and ready to use
 * to power modern apps
 *
 * Copyright 2015-2018 Kuzzle
 * mailto: support AT kuzzle.io
 * website: http://kuzzle.io
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */


const
  sinon = require('sinon');

class KuzzleMock {
  constructor () {
    this.config = {
      services: {
        internalCache: {
          node: {
            host: 'redis'
          }
        }
      }
    };

    this.dsl = {
      storage: {
        filtersIndex: {},
        filters: {},
        store: sinon.spy()
      }
    };

    this.funnel = {
      controllers: {
        realtime: { }
      }
    };

    this.hotelClerk = {
      customers: {},
      rooms: {},
      _removeRoomEverywhere: sinon.spy()
    };

    this.indexCache = {
      add: sinon.spy(),
      remove: sinon.spy(),
      reset: sinon.spy()
    };

    this.notifier = {
      _dispatch: sinon.spy()
    };

    this.pluginsManager = {
      registerStrategy: sinon.spy(),
      strategies: {},
      unregisterStrategy: sinon.spy()
    };

    this.realtime = {
      storage: {}
    };

    this.repositories = {
      profile: {
        profiles: {}
      },
      role: {
        roles: {}
      }
    };

    this.services = {
      list: {
        storageEngine: {
          setAutoRefresh: sinon.spy(),
          settings: {
            autoRefresh: {}
          }
        }
      }
    };

    this.validation = {
      curateSpecification: sinon.spy()
    };

  }
}

module.exports = KuzzleMock;
