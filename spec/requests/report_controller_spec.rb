require 'rails_helper'

describe 'ReportController', type: :request do

  describe 'GET /report' do

    let!(:persisted_seed_data) do
      seed_data.map do |record|
        post '/report', params: record
        fail('POST /report returned an error') unless response.status == 201
        JSON.parse(response.body)
      end
    end

    context 'when no data in the system' do
      let(:seed_data) { [] }
      it 'returns empty array' do
        get '/report'

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq([])
      end
    end

    context 'when no query parameters are provided' do
      let(:seed_data) do
        [
          {
            date: '2020-05-04',
            name: 'John Smith',
            gender: 'm',
            age: 45,
            city: 'East Palatka',
            state: 'FL',
            county: 'Marion',
            latitude: 29.612208,
            longitude: -81.699606
          },
          {
            date: '2020-05-02',
            name: 'Thomas Miller',
            gender: 'm',
            age: 33,
            city: 'Fort Mc Coy',
            state: 'FL',
            county: 'Putnam',
            latitude: 29.390965,
            longitude: -81.855082
          },
        ]
      end

      it 'returns all report records ordered by ID' do
        get '/report'

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq(persisted_seed_data)
      end
    end

    context 'when distance, latitude, longitude parameters are provided' do
      let(:seed_data) do
        [
          {
            date: '2020-05-04',
            name: 'John Smith',
            gender: 'm',
            age: 40,
            city: 'Garland',
            state: 'PA',
            county: 'Warren',
            latitude: 41.818831,
            longitude: -79.446306
          },
          {
            date: '2020-05-02',
            name: 'Thomas Miller',
            gender: 'm',
            age: 38,
            city: 'Holtsville',
            state: 'NY',
            county: 'Suffolk',
            latitude: 40.922326,
            longitude: -72.637078
          },
          {
            date: '2020-05-02',
            name: 'Mary Williams',
            gender: 'f',
            age: 42,
            city: 'Holtsville',
            state: 'NY',
            county: 'Suffolk',
            latitude: 40.922324,
            longitude: -72.637079
          },
          {
            date: '2020-04-30',
            name: 'Mary Green',
            gender: 'f',
            age: 41,
            city: 'Conneautville',
            state: 'PA',
            county: 'Crawford',
            latitude: 41.757871,
            longitude: -80.370323
          },
          {
            date: '2020-04-02',
            name: 'Zoe Knight',
            gender: 'f',
            age: 43,
            city: 'Corry',
            state: 'PA',
            county: 'Crawford',
            latitude: 41.924886,
            longitude: -79.696549
          }
        ]
      end

      it 'returns report records in the specified radius only' do
        get '/report', params: { latitude: 41.92, longitude: -80, distance: 100 }

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq([persisted_seed_data[0], persisted_seed_data[3], persisted_seed_data[4]])
      end
    end

    context 'when only distance and latitude are provided' do
      let(:seed_data) do
        [
          {
            date: '2020-05-04',
            name: 'John Smith',
            gender: 'm',
            age: 40,
            city: 'Garland',
            state: 'PA',
            county: 'Warren',
            latitude: 41.818831,
            longitude: -79.446306
          }
        ]
      end

      it 'returns all report records' do
        get '/report', params: { latitude: 0, distance: 0 }

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq(persisted_seed_data)
      end
    end

    context 'when only distance and longitude are provided' do
      let(:seed_data) do
        [
          {
            date: '2020-05-04',
            name: 'John Smith',
            gender: 'm',
            age: 40,
            city: 'Garland',
            state: 'PA',
            county: 'Warren',
            latitude: 41.818831,
            longitude: -79.446306
          }
        ]
      end

      it 'returns all report records' do
        get '/report', params: { longitude: 0, distance: 0 }

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq(persisted_seed_data)
      end
    end

    context 'when only latitude and longitude are provided' do
      let(:seed_data) do
        [
          {
            date: '2020-05-04',
            name: 'John Smith',
            gender: 'm',
            age: 40,
            city: 'Garland',
            state: 'PA',
            county: 'Warren',
            latitude: 41.818831,
            longitude: -79.446306
          }
        ]
      end

      it 'returns all report records' do
        get '/report', params: { longitude: 0, latitude: 0 }

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq(persisted_seed_data)
      end
    end

    context 'when age_from parameter is provided' do
      let(:seed_data) do
        [
          {
            date: '2020-05-04',
            name: 'John Smith',
            gender: 'm',
            age: 40,
            city: 'East Palatka',
            state: 'FL',
            county: 'Marion',
            latitude: 29.612208,
            longitude: -81.699606
          },
          {
            date: '2020-05-02',
            name: 'Thomas Miller',
            gender: 'm',
            age: 39,
            city: 'Fort Mc Coy',
            state: 'FL',
            county: 'Putnam',
            latitude: 29.390965,
            longitude: -81.855082
          },
          {
            date: '2020-05-02',
            name: 'Mary Williams',
            gender: 'f',
            age: 41,
            city: 'Fort Mc Coy',
            state: 'FL',
            county: 'Putnam',
            latitude: 29.390965,
            longitude: -81.855082
          }
        ]
      end

      it 'returns report records of people not younger than specified parameter' do
        get '/report', params: {age_from: 40}

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq([persisted_seed_data[0], persisted_seed_data[2]])
      end
    end

    context 'when age_to parameter is provided' do
      let(:seed_data) do
        [
          {
            date: '2020-05-04',
            name: 'John Smith',
            gender: 'm',
            age: 35,
            city: 'East Palatka',
            state: 'FL',
            county: 'Marion',
            latitude: 29.612208,
            longitude: -81.699606
          },
          {
            date: '2020-05-02',
            name: 'Thomas Miller',
            gender: 'm',
            age: 39,
            city: 'Fort Mc Coy',
            state: 'FL',
            county: 'Putnam',
            latitude: 29.390965,
            longitude: -81.855082
          },
          {
            date: '2020-05-02',
            name: 'Mary Williams',
            gender: 'f',
            age: 45,
            city: 'Fort Mc Coy',
            state: 'FL',
            county: 'Putnam',
            latitude: 29.390965,
            longitude: -81.855082
          }
        ]
      end

      it 'returns report records of people not older than specified parameter' do
        get '/report', params: {age_to: 39}

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq([persisted_seed_data[0], persisted_seed_data[1]])
      end
    end

    context 'when both age_from and age_to parameters are provided' do
      let(:seed_data) do
        [
          {
            date: '2020-05-04',
            name: 'John Smith',
            gender: 'm',
            age: 40,
            city: 'East Palatka',
            state: 'FL',
            county: 'Marion',
            latitude: 29.612208,
            longitude: -81.699606
          },
          {
            date: '2020-05-02',
            name: 'Thomas Miller',
            gender: 'm',
            age: 38,
            city: 'Fort Mc Coy',
            state: 'FL',
            county: 'Putnam',
            latitude: 29.390965,
            longitude: -81.855082
          },
          {
            date: '2020-05-02',
            name: 'Mary Williams',
            gender: 'f',
            age: 42,
            city: 'Fort Mc Coy',
            state: 'FL',
            county: 'Putnam',
            latitude: 29.390965,
            longitude: -81.855082
          },
          {
            date: '2020-04-30',
            name: 'Mary Green',
            gender: 'f',
            age: 41,
            city: 'Fort Mc Coy',
            state: 'FL',
            county: 'Putnam',
            latitude: 29.390965,
            longitude: -81.855082
          },
          {
            date: '2020-04-02',
            name: 'Zoe Knight',
            gender: 'f',
            age: 43,
            city: 'Fort Mc Coy',
            state: 'FL',
            county: 'Putnam',
            latitude: 29.390465,
            longitude: -81.855072
          }
        ]
      end

      it 'returns report records of people, whose age is in the range of specified parameters' do
        get '/report', params: {age_from: 40, age_to: 42}

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq([persisted_seed_data[0], persisted_seed_data[2], persisted_seed_data[3]])
      end
    end

    context 'when date_from parameter is provided' do
      let(:seed_data) do
        [
          {
            date: '2020-05-04',
            name: 'John Smith',
            gender: 'm',
            age: 35,
            city: 'East Palatka',
            state: 'FL',
            county: 'Marion',
            latitude: 29.612208,
            longitude: -81.699606
          },
          {
            date: '2020-05-03',
            name: 'Thomas Miller',
            gender: 'm',
            age: 39,
            city: 'Fort Mc Coy',
            state: 'FL',
            county: 'Putnam',
            latitude: 29.390965,
            longitude: -81.855082
          },
          {
            date: '2020-05-05',
            name: 'Mary Williams',
            gender: 'f',
            age: 45,
            city: 'Fort Mc Coy',
            state: 'FL',
            county: 'Putnam',
            latitude: 29.390965,
            longitude: -81.855082
          }
        ]
      end

      it 'returns report records, which are received not earlier than specified date' do
        get '/report', params: {date_from: '2020-05-04'}

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq([persisted_seed_data[0], persisted_seed_data[2]])
      end
    end

    context 'when date_to parameter is provided' do
      let(:seed_data) do
        [
          {
            date: '2020-05-04',
            name: 'John Smith',
            gender: 'm',
            age: 35,
            city: 'East Palatka',
            state: 'FL',
            county: 'Marion',
            latitude: 29.612208,
            longitude: -81.699606
          },
          {
            date: '2020-05-03',
            name: 'Thomas Miller',
            gender: 'm',
            age: 39,
            city: 'Fort Mc Coy',
            state: 'FL',
            county: 'Putnam',
            latitude: 29.390965,
            longitude: -81.855082
          },
          {
            date: '2020-05-05',
            name: 'Mary Williams',
            gender: 'f',
            age: 45,
            city: 'Fort Mc Coy',
            state: 'FL',
            county: 'Putnam',
            latitude: 29.390965,
            longitude: -81.855082
          }
        ]
      end

      it 'returns report records, which are received not later than specified date' do
        get '/report', params: {date_to: '2020-05-04'}

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq([persisted_seed_data[0], persisted_seed_data[1]])
      end
    end

    context 'when both date_from and date_to parameters are provided' do
      let(:seed_data) do
        [
          {
            date: '2020-05-02',
            name: 'John Smith',
            gender: 'm',
            age: 40,
            city: 'East Palatka',
            state: 'FL',
            county: 'Marion',
            latitude: 29.612208,
            longitude: -81.699606
          },
          {
            date: '2020-05-04',
            name: 'Thomas Miller',
            gender: 'm',
            age: 39,
            city: 'Fort Mc Coy',
            state: 'FL',
            county: 'Putnam',
            latitude: 29.390965,
            longitude: -81.855082
          },
          {
            date: '2020-05-05',
            name: 'Thomas Green',
            gender: 'm',
            age: 21,
            city: 'Fort Mc Coy',
            state: 'FL',
            county: 'Putnam',
            latitude: 29.390965,
            longitude: -81.855082
          },
          {
            date: '2020-05-06',
            name: 'Mary Williams',
            gender: 'f',
            age: 41,
            city: 'Fort Mc Coy',
            state: 'FL',
            county: 'Putnam',
            latitude: 29.390965,
            longitude: -81.855082
          },
          {
            date: '2020-04-08',
            name: 'Zoe Knight',
            gender: 'f',
            age: 42,
            city: 'Fort Mc Coy',
            state: 'FL',
            county: 'Putnam',
            latitude: 29.390465,
            longitude: -81.855072
          }
        ]
      end

      it 'returns report records, which are received in the range of specified dates' do
        get '/report', params: {date_from: '2020-05-04', date_to: '2020-05-06'}

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq([persisted_seed_data[1], persisted_seed_data[2], persisted_seed_data[3]])
      end
    end

    context 'when gender parameter is provided' do
      let(:seed_data) do
        [
          {
            date: '2020-05-04',
            name: 'John Smith',
            gender: 'm',
            age: 35,
            city: 'East Palatka',
            state: 'FL',
            county: 'Marion',
            latitude: 29.612208,
            longitude: -81.699606
          },
          {
            date: '2020-05-05',
            name: 'Mary Williams',
            gender: 'f',
            age: 45,
            city: 'Fort Mc Coy',
            state: 'FL',
            county: 'Putnam',
            latitude: 29.390965,
            longitude: -81.855082
          }
        ]
      end

      it 'returns report records of people of a given gender' do
        get '/report', params: {gender: 'm'}

        expect(response.status).to eq(200)
        expect(JSON.parse(response.body)).to eq([persisted_seed_data[0]])
      end
    end
  end
end
