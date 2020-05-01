{--
Copyright (c) 2020 Target Brands, Inc. All rights reserved.
Use of this source code is governed by the LICENSE file in this repository.
--}


module Pages.Secrets.Model exposing
    ( AddSecretResponse
    , ManageSecretState(..)
    , Model
    , Msg(..)
    , PartialModel
    , SecretForm
    , SecretResponse
    , SecretsResponse
    , UpdateSecretResponse
    , defaultSecretUpdate
    )

import Http
import Http.Detailed
import Pages exposing (Page(..))
import RemoteData exposing (RemoteData(..), WebData)
import Vela
    exposing
        ( Engine
        , Org
        , Repo
        , Secret
        , SecretType
        , Secrets
        , Session
        , Team
        )



-- TYPES


{-| PartialModel : an abbreviated version of the main model
-}
type alias PartialModel a msg =
    { a
        | velaAPI : String
        , session : Maybe Session
        , secretsModel : Model msg
    }


{-| Model : record to hold page input arguments
-}
type alias Model msg =
    { org : Org
    , repo : Repo
    , team : Team
    , engine : Engine
    , type_ : SecretType
    , secrets : WebData Secrets
    , form : SecretForm
    , secretResponse : SecretResponse msg
    , secretsResponse : SecretsResponse msg
    , addSecretResponse : AddSecretResponse msg
    , updateSecretResponse : AddSecretResponse msg
    }


{-| SecretForm : record to hold potential add/update secret fields
-}
type alias SecretForm =
    { name : String
    , value : String
    , events : List String
    , imageInput : String
    , images : List String
    , allowCommand : Bool
    }


defaultSecretUpdate : SecretForm
defaultSecretUpdate =
    SecretForm "" "" [] "" [] True



-- MSG


type alias SecretResponse msg =
    Result (Http.Detailed.Error String) ( Http.Metadata, Secret ) -> msg


type alias SecretsResponse msg =
    Result (Http.Detailed.Error String) ( Http.Metadata, Secrets ) -> msg


type alias AddSecretResponse msg =
    Result (Http.Detailed.Error String) ( Http.Metadata, Secret ) -> msg


type alias UpdateSecretResponse msg =
    Result (Http.Detailed.Error String) ( Http.Metadata, Secret ) -> msg


type Msg
    = OnChangeStringField String String
    | OnChangeEvent String Bool
    | AddImage String
    | RemoveImage String
    | OnChangeAllowCommand String
    | AddSecret Engine
    | UpdateSecret Engine


type ManageSecretState
    = Choose
    | Add
    | Update
